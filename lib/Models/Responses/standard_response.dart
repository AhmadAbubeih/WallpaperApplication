class StandardResponse {
  int? status;
  String? message;

  StandardResponse(this.status, this.message);

  StandardResponse.fromJson(Map<String, dynamic> json) {
    status = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
