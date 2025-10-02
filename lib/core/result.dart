/// A lightweight Result/Either abstraction for success & failure handling.
sealed class Result<T> {
  const Result();
  R when<R>({required R Function(T data) success, required R Function(Failure failure) failure}) {
    final self = this;
    if (self is Success<T>) return success(self.data);
    return failure((self as FailureResult<T>).failure);
  }
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;
  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  Failure? get failureOrNull => this is FailureResult<T> ? (this as FailureResult<T>).failure : null;
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}

/// Base failure type
sealed class Failure {
  final String message;
  final Object? cause;
  final StackTrace? stack;
  const Failure(this.message, {this.cause, this.stack});
  @override
  String toString() => 'Failure($message)';
}

class NetworkFailure extends Failure { const NetworkFailure(String msg,{Object? cause, StackTrace? stack}) : super(msg,cause: cause, stack: stack); }
class AuthFailure extends Failure { const AuthFailure(String msg,{Object? cause, StackTrace? stack}) : super(msg,cause: cause, stack: stack); }
class NotFoundFailure extends Failure { const NotFoundFailure(String msg,{Object? cause, StackTrace? stack}) : super(msg,cause: cause, stack: stack); }
class ValidationFailure extends Failure { const ValidationFailure(String msg,{Object? cause, StackTrace? stack}) : super(msg,cause: cause, stack: stack); }
class UnknownFailure extends Failure { const UnknownFailure(String msg,{Object? cause, StackTrace? stack}) : super(msg,cause: cause, stack: stack); }

extension ResultX<T> on Result<T> {
  T get requireData {
    final self = this;
    if (self is Success<T>) return self.data;
    throw (self as FailureResult<T>).failure;
  }
}
