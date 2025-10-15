// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  Object? get cause => throw _privateConstructorUsedError;
  StackTrace? get stack => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message, Object? cause, StackTrace? stack});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            cause: freezed == cause ? _value.cause : cause,
            stack: freezed == stack
                ? _value.stack
                : stack // ignore: cast_nullable_to_non_nullable
                      as StackTrace?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    int? statusCode,
    Object? cause,
    StackTrace? stack,
  });
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$NetworkFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl extends NetworkFailure {
  const _$NetworkFailureImpl(
    this.message, {
    this.statusCode,
    this.cause,
    this.stack,
  }) : super._();

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.network(message: $message, statusCode: $statusCode, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    statusCode,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return network(message, statusCode, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return network?.call(message, statusCode, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, statusCode, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure(
    final String message, {
    final int? statusCode,
    final Object? cause,
    final StackTrace? stack,
  }) = _$NetworkFailureImpl;
  const NetworkFailure._() : super._();

  @override
  String get message;
  int? get statusCode;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
    _$AuthFailureImpl value,
    $Res Function(_$AuthFailureImpl) then,
  ) = __$$AuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code, Object? cause, StackTrace? stack});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
    _$AuthFailureImpl _value,
    $Res Function(_$AuthFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$AuthFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$AuthFailureImpl extends AuthFailure {
  const _$AuthFailureImpl(this.message, {this.code, this.cause, this.stack})
    : super._();

  @override
  final String message;
  @override
  final String? code;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.auth(message: $message, code: $code, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    code,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return auth(message, code, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return auth?.call(message, code, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message, code, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthFailure extends Failure {
  const factory AuthFailure(
    final String message, {
    final String? code,
    final Object? cause,
    final StackTrace? stack,
  }) = _$AuthFailureImpl;
  const AuthFailure._() : super._();

  @override
  String get message;
  String? get code;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(
    _$NotFoundFailureImpl value,
    $Res Function(_$NotFoundFailureImpl) then,
  ) = __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String? resource,
    Object? cause,
    StackTrace? stack,
  });
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
    _$NotFoundFailureImpl _value,
    $Res Function(_$NotFoundFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? resource = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$NotFoundFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        resource: freezed == resource
            ? _value.resource
            : resource // ignore: cast_nullable_to_non_nullable
                  as String?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundFailureImpl extends NotFoundFailure {
  const _$NotFoundFailureImpl(
    this.message, {
    this.resource,
    this.cause,
    this.stack,
  }) : super._();

  @override
  final String message;
  @override
  final String? resource;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.notFound(message: $message, resource: $resource, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.resource, resource) ||
                other.resource == resource) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    resource,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return notFound(message, resource, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return notFound?.call(message, resource, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message, resource, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure extends Failure {
  const factory NotFoundFailure(
    final String message, {
    final String? resource,
    final Object? cause,
    final StackTrace? stack,
  }) = _$NotFoundFailureImpl;
  const NotFoundFailure._() : super._();

  @override
  String get message;
  String? get resource;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    Map<String, String>? fieldErrors,
    Object? cause,
    StackTrace? stack,
  });
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fieldErrors = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$ValidationFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldErrors: freezed == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl extends ValidationFailure {
  const _$ValidationFailureImpl(
    this.message, {
    final Map<String, String>? fieldErrors,
    this.cause,
    this.stack,
  }) : _fieldErrors = fieldErrors,
       super._();

  @override
  final String message;
  final Map<String, String>? _fieldErrors;
  @override
  Map<String, String>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.validation(message: $message, fieldErrors: $fieldErrors, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_fieldErrors),
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return validation(message, fieldErrors, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return validation?.call(message, fieldErrors, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, fieldErrors, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure extends Failure {
  const factory ValidationFailure(
    final String message, {
    final Map<String, String>? fieldErrors,
    final Object? cause,
    final StackTrace? stack,
  }) = _$ValidationFailureImpl;
  const ValidationFailure._() : super._();

  @override
  String get message;
  Map<String, String>? get fieldErrors;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$PermissionFailureImplCopyWith(
    _$PermissionFailureImpl value,
    $Res Function(_$PermissionFailureImpl) then,
  ) = __$$PermissionFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String? permission,
    Object? cause,
    StackTrace? stack,
  });
}

/// @nodoc
class __$$PermissionFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$PermissionFailureImpl>
    implements _$$PermissionFailureImplCopyWith<$Res> {
  __$$PermissionFailureImplCopyWithImpl(
    _$PermissionFailureImpl _value,
    $Res Function(_$PermissionFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? permission = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$PermissionFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        permission: freezed == permission
            ? _value.permission
            : permission // ignore: cast_nullable_to_non_nullable
                  as String?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$PermissionFailureImpl extends PermissionFailure {
  const _$PermissionFailureImpl(
    this.message, {
    this.permission,
    this.cause,
    this.stack,
  }) : super._();

  @override
  final String message;
  @override
  final String? permission;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.permission(message: $message, permission: $permission, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.permission, permission) ||
                other.permission == permission) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    permission,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      __$$PermissionFailureImplCopyWithImpl<_$PermissionFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return permission(message, this.permission, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return permission?.call(message, this.permission, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(message, this.permission, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return permission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return permission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(this);
    }
    return orElse();
  }
}

abstract class PermissionFailure extends Failure {
  const factory PermissionFailure(
    final String message, {
    final String? permission,
    final Object? cause,
    final StackTrace? stack,
  }) = _$PermissionFailureImpl;
  const PermissionFailure._() : super._();

  @override
  String get message;
  String? get permission;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RateLimitFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$RateLimitFailureImplCopyWith(
    _$RateLimitFailureImpl value,
    $Res Function(_$RateLimitFailureImpl) then,
  ) = __$$RateLimitFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    Duration? retryAfter,
    Object? cause,
    StackTrace? stack,
  });
}

/// @nodoc
class __$$RateLimitFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$RateLimitFailureImpl>
    implements _$$RateLimitFailureImplCopyWith<$Res> {
  __$$RateLimitFailureImplCopyWithImpl(
    _$RateLimitFailureImpl _value,
    $Res Function(_$RateLimitFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? retryAfter = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$RateLimitFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        retryAfter: freezed == retryAfter
            ? _value.retryAfter
            : retryAfter // ignore: cast_nullable_to_non_nullable
                  as Duration?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$RateLimitFailureImpl extends RateLimitFailure {
  const _$RateLimitFailureImpl(
    this.message, {
    this.retryAfter,
    this.cause,
    this.stack,
  }) : super._();

  @override
  final String message;
  @override
  final Duration? retryAfter;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.rateLimit(message: $message, retryAfter: $retryAfter, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateLimitFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.retryAfter, retryAfter) ||
                other.retryAfter == retryAfter) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    retryAfter,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RateLimitFailureImplCopyWith<_$RateLimitFailureImpl> get copyWith =>
      __$$RateLimitFailureImplCopyWithImpl<_$RateLimitFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return rateLimit(message, retryAfter, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return rateLimit?.call(message, retryAfter, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (rateLimit != null) {
      return rateLimit(message, retryAfter, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return rateLimit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return rateLimit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (rateLimit != null) {
      return rateLimit(this);
    }
    return orElse();
  }
}

abstract class RateLimitFailure extends Failure {
  const factory RateLimitFailure(
    final String message, {
    final Duration? retryAfter,
    final Object? cause,
    final StackTrace? stack,
  }) = _$RateLimitFailureImpl;
  const RateLimitFailure._() : super._();

  @override
  String get message;
  Duration? get retryAfter;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RateLimitFailureImplCopyWith<_$RateLimitFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StorageFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$StorageFailureImplCopyWith(
    _$StorageFailureImpl value,
    $Res Function(_$StorageFailureImpl) then,
  ) = __$$StorageFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String? provider,
    Object? cause,
    StackTrace? stack,
  });
}

/// @nodoc
class __$$StorageFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$StorageFailureImpl>
    implements _$$StorageFailureImplCopyWith<$Res> {
  __$$StorageFailureImplCopyWithImpl(
    _$StorageFailureImpl _value,
    $Res Function(_$StorageFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? provider = freezed,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$StorageFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: freezed == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String?,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$StorageFailureImpl extends StorageFailure {
  const _$StorageFailureImpl(
    this.message, {
    this.provider,
    this.cause,
    this.stack,
  }) : super._();

  @override
  final String message;
  @override
  final String? provider;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.storage(message: $message, provider: $provider, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    provider,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageFailureImplCopyWith<_$StorageFailureImpl> get copyWith =>
      __$$StorageFailureImplCopyWithImpl<_$StorageFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return storage(message, provider, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return storage?.call(message, provider, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(message, provider, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }
}

abstract class StorageFailure extends Failure {
  const factory StorageFailure(
    final String message, {
    final String? provider,
    final Object? cause,
    final StackTrace? stack,
  }) = _$StorageFailureImpl;
  const StorageFailure._() : super._();

  @override
  String get message;
  String? get provider;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageFailureImplCopyWith<_$StorageFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? cause, StackTrace? stack});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(
      _$UnknownFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        cause: freezed == cause ? _value.cause : cause,
        stack: freezed == stack
            ? _value.stack
            : stack // ignore: cast_nullable_to_non_nullable
                  as StackTrace?,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl extends UnknownFailure {
  const _$UnknownFailureImpl(this.message, {this.cause, this.stack})
    : super._();

  @override
  final String message;
  @override
  final Object? cause;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'Failure.unknown(message: $message, cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(cause),
    stack,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )
    network,
    required TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )
    auth,
    required TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )
    notFound,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )
    validation,
    required TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )
    permission,
    required TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )
    rateLimit,
    required TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )
    storage,
    required TResult Function(String message, Object? cause, StackTrace? stack)
    unknown,
  }) {
    return unknown(message, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult? Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult? Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult? Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult? Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult? Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult? Function(String message, Object? cause, StackTrace? stack)?
    unknown,
  }) {
    return unknown?.call(message, cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String message,
      int? statusCode,
      Object? cause,
      StackTrace? stack,
    )?
    network,
    TResult Function(
      String message,
      String? code,
      Object? cause,
      StackTrace? stack,
    )?
    auth,
    TResult Function(
      String message,
      String? resource,
      Object? cause,
      StackTrace? stack,
    )?
    notFound,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      Object? cause,
      StackTrace? stack,
    )?
    validation,
    TResult Function(
      String message,
      String? permission,
      Object? cause,
      StackTrace? stack,
    )?
    permission,
    TResult Function(
      String message,
      Duration? retryAfter,
      Object? cause,
      StackTrace? stack,
    )?
    rateLimit,
    TResult Function(
      String message,
      String? provider,
      Object? cause,
      StackTrace? stack,
    )?
    storage,
    TResult Function(String message, Object? cause, StackTrace? stack)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(RateLimitFailure value) rateLimit,
    required TResult Function(StorageFailure value) storage,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(RateLimitFailure value)? rateLimit,
    TResult? Function(StorageFailure value)? storage,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(AuthFailure value)? auth,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(RateLimitFailure value)? rateLimit,
    TResult Function(StorageFailure value)? storage,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure extends Failure {
  const factory UnknownFailure(
    final String message, {
    final Object? cause,
    final StackTrace? stack,
  }) = _$UnknownFailureImpl;
  const UnknownFailure._() : super._();

  @override
  String get message;
  @override
  Object? get cause;
  @override
  StackTrace? get stack;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
