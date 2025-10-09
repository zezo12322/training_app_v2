/// A lightweight Result/Either abstraction for success & failure handling.
library;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseException;
import 'package:training_app/core/l10n_ext.dart';
import 'package:flutter/widgets.dart';

part 'result.freezed.dart';

/// A lightweight Result abstraction (Success / Failure) with Freezed-powered Failure union.
sealed class Result<T> {
  const Result();
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    final self = this;
    if (self is Success<T>) return success(self.data);
    return failure((self as FailureResult<T>).failure);
  }

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  Failure? get failureOrNull =>
      this is FailureResult<T> ? (this as FailureResult<T>).failure : null;
  Result<R> map<R>(R Function(T data) transform) => this is Success<T>
      ? Success<R>(transform((this as Success<T>).data))
      : FailureResult<R>((this as FailureResult<T>).failure);
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}

/// Failure union – add variants as needed.
@freezed
class Failure with _$Failure {
  const Failure._();
  const factory Failure.network(
    String message, {
    int? statusCode,
    Object? cause,
    StackTrace? stack,
  }) = NetworkFailure;
  const factory Failure.auth(
    String message, {
    String? code,
    Object? cause,
    StackTrace? stack,
  }) = AuthFailure;
  const factory Failure.notFound(
    String message, {
    String? resource,
    Object? cause,
    StackTrace? stack,
  }) = NotFoundFailure;
  const factory Failure.validation(
    String message, {
    Map<String, String>? fieldErrors,
    Object? cause,
    StackTrace? stack,
  }) = ValidationFailure;
  const factory Failure.permission(
    String message, {
    String? permission,
    Object? cause,
    StackTrace? stack,
  }) = PermissionFailure;
  const factory Failure.rateLimit(
    String message, {
    Duration? retryAfter,
    Object? cause,
    StackTrace? stack,
  }) = RateLimitFailure;
  const factory Failure.storage(
    String message, {
    String? provider,
    Object? cause,
    StackTrace? stack,
  }) = StorageFailure;
  const factory Failure.unknown(
    String message, {
    Object? cause,
    StackTrace? stack,
  }) = UnknownFailure;

  bool get isRetryable => maybeWhen(
    network: (message, statusCode, cause, stack) => true,
    rateLimit: (message, retryAfter, cause, stack) => true,
    storage: (message, provider, cause, stack) => true,
    orElse: () => false,
  );

  /// Returns a stable message *code* (not user facing text). UI layer maps it via localization.
  String messageCode() => when(
    network: (m, statusCode, cause, stack) => 'network_error',
    auth: (m, code, cause, stack) => 'auth_error',
    notFound: (m, resource, cause, stack) => 'not_found',
    validation: (m, fieldErrors, cause, stack) => 'validation_error',
    permission: (m, permission, cause, stack) => 'permission_denied',
    rateLimit: (m, retryAfter, cause, stack) => 'rate_limited',
    storage: (m, provider, cause, stack) => 'storage_error',
    unknown: (m, cause, stack) => 'unknown_error',
  );

  /// UI helper: translate this failure using non-nullable localization extension.
  /// Falls back to the stable messageCode() if anything goes wrong.
  String localizedMessage(BuildContext context) {
    try {
      final l = context.l; // non-null via extension
      return when(
        network: (m, statusCode, cause, stack) => l.errorNetwork,
        auth: (m, code, cause, stack) => l.errorAuth(_codeOrMsg(code, m)),
        notFound: (m, resource, cause, stack) => resource != null
            ? l.errorNotFoundResource(resource)
            : l.errorNotFound,
        validation: (m, fieldErrors, cause, stack) =>
            fieldErrors != null && fieldErrors.isNotEmpty
            ? fieldErrors.values.join('\n')
            : l.errorValidation,
        permission: (m, permission, cause, stack) => l.errorPermission,
        rateLimit: (m, retryAfter, cause, stack) => retryAfter != null
            ? l.errorRateLimitedRetry(retryAfter.inSeconds.toString())
            : l.errorRateLimited,
        storage: (m, provider, cause, stack) => l.errorStorage,
        unknown: (m, cause, stack) => l.errorUnknown,
      );
    } catch (_) {
      return messageCode();
    }
  }

  Map<String, Object?> toLogMap() => {
    'type': map(
      network: (_) => 'network',
      auth: (_) => 'auth',
      notFound: (_) => 'notFound',
      validation: (_) => 'validation',
      permission: (_) => 'permission',
      rateLimit: (_) => 'rateLimit',
      storage: (_) => 'storage',
      unknown: (_) => 'unknown',
    ),
    'message': when(
      network: (m, statusCode, cause, stack) => m,
      auth: (m, code, cause, stack) => m,
      notFound: (m, resource, cause, stack) => m,
      validation: (m, fieldErrors, cause, stack) => m,
      permission: (m, permission, cause, stack) => m,
      rateLimit: (m, retryAfter, cause, stack) => m,
      storage: (m, provider, cause, stack) => m,
      unknown: (m, cause, stack) => m,
    ),
    'metadata': when(
      network: (m, statusCode, cause, stack) => {'statusCode': statusCode},
      auth: (m, code, cause, stack) => {'code': code},
      notFound: (m, resource, cause, stack) => {'resource': resource},
      validation: (m, fieldErrors, cause, stack) => {'fields': fieldErrors},
      permission: (m, permission, cause, stack) => {'permission': permission},
      rateLimit: (m, retryAfter, cause, stack) => {
        'retryAfterMs': retryAfter?.inMilliseconds,
      },
      storage: (m, provider, cause, stack) => {'provider': provider},
      unknown: (m, cause, stack) => {},
    ),
  };
}

String _codeOrMsg(String? code, String msg) =>
    code != null ? '$msg ($code)' : msg;

extension ResultX<T> on Result<T> {
  T get requireData {
    final self = this;
    if (self is Success<T>) return self.data;
    throw (self as FailureResult<T>).failure;
  }

  Failure? get failureOr =>
      this is FailureResult<T> ? (this as FailureResult<T>).failure : null;
  Result<T> onFailure(void Function(Failure f) action) {
    if (this is FailureResult<T>) action((this as FailureResult<T>).failure);
    return this;
  }
}

/// Helper to wrap a throwing function into Result.
Future<Result<T>> guard<T>(
  Future<T> Function() op, {
  Failure Function(Object e, StackTrace s)? map,
}) async {
  try {
    final v = await op();
    return Success(v);
  } catch (e, s) {
    final failure = map?.call(e, s) ?? _defaultMap(e, s);
    return FailureResult(failure);
  }
}

Failure _defaultMap(Object e, StackTrace s) {
  if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'network-request-failed':
        return Failure.network('network', cause: e, stack: s);
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return Failure.auth(
          'invalid_credentials',
          code: e.code,
          cause: e,
          stack: s,
        );
      case 'too-many-requests':
        return Failure.rateLimit(
          'too_many_requests',
          retryAfter: const Duration(seconds: 30),
          cause: e,
          stack: s,
        );
      default:
        return Failure.auth(
          e.message ?? 'auth_error',
          code: e.code,
          cause: e,
          stack: s,
        );
    }
  }
  if (e is FirebaseException) {
    switch (e.code) {
      case 'not-found':
        return Failure.notFound(
          'resource_not_found',
          resource: e.plugin,
          cause: e,
          stack: s,
        );
      case 'permission-denied':
        return Failure.permission(
          'permission_denied',
          permission: e.plugin,
          cause: e,
          stack: s,
        );
      case 'unavailable':
        return Failure.network('service_unavailable', cause: e, stack: s);
      case 'deadline-exceeded':
        return Failure.network('deadline_exceeded', cause: e, stack: s);
      case 'resource-exhausted':
        return Failure.rateLimit(
          'quota_exhausted',
          retryAfter: const Duration(seconds: 20),
          cause: e,
          stack: s,
        );
      default:
        return Failure.unknown(
          e.message ?? 'unknown_error',
          cause: e,
          stack: s,
        );
    }
  }
  final msg = e.toString();
  if (msg.contains('SocketException')) {
    return Failure.network('socket_exception', cause: e, stack: s);
  }
  return Failure.unknown(msg, cause: e, stack: s);
}
