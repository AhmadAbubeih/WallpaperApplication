import 'package:dio/dio.dart';

class ApiClient {
  static String baseUrl = "https://api.pexels.com/v1/";

  static Dio getDio() {
    BaseOptions options = BaseOptions(
        followRedirects: false,
        baseUrl: baseUrl,
        responseType: ResponseType.plain,
        connectTimeout: const Duration(seconds: 60),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
          "X-Requested-With": "XMLHttpRequest",
          "Authorization":
              "cjt4lFjbYuGQDz1iBKglRnuw8gwA14swKquwWX146s3ActqSoD0uW4X2",
        });

    Dio dio = Dio(options);

    return dio;
  }
}
