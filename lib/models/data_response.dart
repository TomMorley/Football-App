class DataResponse {
  final dynamic data;
  String? error;
  int? errorCode;

  DataResponse({
    this.data,
    this.error,
    this.errorCode
  });

  DataResponse.fromData(this.data);


  static DataResponse withError(String error, {int? errorCode}) {
    DataResponse response = DataResponse();
    response.error = error;
    response.errorCode = errorCode;
    return response;
  }
}