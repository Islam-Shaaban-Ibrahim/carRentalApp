sealed class Result<T> {
  const Result();

  const factory Result.success(T value) = Success._;

  const factory Result.error(String message) = Error._;

  dynamic when(Function(String message) error, Function(T value) success) {
    switch (this) {
      case Success():
        return success((this as Success).value);
      case Error():
        return error((this as Error).message);
    }
  }
}

final class Success<T> extends Result<T> {
  const Success._(this.value);

  final T value;
}

final class Error<T> extends Result<T> {
  const Error._(this.message);

  final String message;
}
