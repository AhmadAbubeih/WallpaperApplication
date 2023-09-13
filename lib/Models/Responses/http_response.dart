class HttpResponse<T> {
  bool? isSuccess;
  T? data;
  String? message;
  int? responseCode;
  int? status;

  HttpResponse({
    this.isSuccess,
    this.data,
    this.message,
    this.responseCode,
    this.status,
  });
}
