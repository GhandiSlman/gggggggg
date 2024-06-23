abstract class DataState<T> {
  DataState({this.data, this.errorMessage, this.statusCode});

  final T? data;
  final String? errorMessage;
  final int? statusCode;
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String errorMessage, {int statusCode = 500}) : super(errorMessage: errorMessage, statusCode: statusCode);
}
