class DataResponse<T> {
  final T? data;
  String? error;
  int? errorCode;

  DataResponse({
    this.data,
    this.error,
    this.errorCode
  });

  DataResponse.fromData(this.data);


  DataResponse.withError(this.error, {this.errorCode})
    :
      data = null;
}