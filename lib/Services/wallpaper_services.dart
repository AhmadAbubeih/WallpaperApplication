import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wallpaper_app/Models/Responses/random_wallpapers_response.dart';
import 'package:wallpaper_app/Models/Responses/search_wallpapers_response.dart';
import '../Api/api_client.dart';
import '../Models/Responses/http_response.dart';
import '../Models/Responses/standard_response.dart';

class WallpaperServices {
  Dio? _dio;

  WallpaperServices() {
    _dio = ApiClient.getDio();
  }

  Future<HttpResponse<RandomWallpaperResponse>> getRandomWallpapers(
      int pageNumber) async {
    try {
      final response = await _dio!.get("/curated?page=$pageNumber&per_page=10");

      if (response.statusCode == 200) {
        RandomWallpaperResponse randomWallpaperResponse =
            RandomWallpaperResponse.fromJson(json.decode(response.data));

        return HttpResponse(
            isSuccess: true, data: randomWallpaperResponse, responseCode: 200);
      } else {
        StandardResponse standardResponse =
            StandardResponse.fromJson(json.decode(response.data));

        return HttpResponse(
            isSuccess: false,
            message: standardResponse.message,
            responseCode: standardResponse.status);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.message!.contains("SocketException")) {
          return HttpResponse(
              isSuccess: false,
              message: "Connection Failed",
              responseCode: 500);
        } else if (e.response != null) {
          return HttpResponse(
              message: e.response!.statusMessage, responseCode: 401);
        } else {
          return HttpResponse(
              message: "Something Went Wrong", responseCode: 401);
        }
      } else {
        return HttpResponse(
            isSuccess: false, message: e.toString(), responseCode: 500);
      }
    }
  }

  Future<HttpResponse<SearchWallpaperResponse>> searchWallpapers(
      String wallpaperName, int pageNumber) async {
    try {
      final response = await _dio!
          .get("/search?query=$wallpaperName&page=$pageNumber&per_page=10");

      if (response.statusCode == 200) {
        SearchWallpaperResponse searchWallpaperResponse =
            SearchWallpaperResponse.fromJson(json.decode(response.data));

        return HttpResponse(
            isSuccess: true, data: searchWallpaperResponse, responseCode: 200);
      } else {
        StandardResponse standardResponse =
            StandardResponse.fromJson(json.decode(response.data));

        return HttpResponse(
            isSuccess: false,
            message: standardResponse.message,
            responseCode: standardResponse.status);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.message!.contains("SocketException")) {
          return HttpResponse(
              isSuccess: false,
              message: "Connection Failed",
              responseCode: 500);
        } else if (e.response != null) {
          return HttpResponse(
              message: e.response!.statusMessage, responseCode: 401);
        } else {
          return HttpResponse(
              message: "Something Went Wrong", responseCode: 401);
        }
      } else {
        return HttpResponse(
            isSuccess: false, message: e.toString(), responseCode: 500);
      }
    }
  }
}
