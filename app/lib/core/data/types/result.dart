sealed class Result<T> {}

class ResultData<T> extends Result<T> {
  final T data;
  ResultData(this.data);
}

class ResultFailure<T> extends Result<T> {
  final String message;
  ResultFailure(this.message);
}
