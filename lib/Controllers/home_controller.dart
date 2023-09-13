import 'package:flutter/material.dart';
import 'package:wallpaper_app/Models/Api/wallpaper.dart';
import 'package:wallpaper_app/Models/Responses/random_wallpapers_response.dart';
import 'package:wallpaper_app/Models/Responses/search_wallpapers_response.dart';
import 'package:wallpaper_app/Services/wallpaper_services.dart';
import '../Models/Responses/http_response.dart';

class WallpaperController with ChangeNotifier {
  final WallpaperServices _wallpaperServices = WallpaperServices();

  int? pageNumber = 0;

  int? totalNumber = 0;

  List<Photos>? wallpaperPhotos;

  Future<void> getRandomWallpapers() async {
    pageNumber = pageNumber! + 1;

    HttpResponse<RandomWallpaperResponse> response =
        await _wallpaperServices.getRandomWallpapers(pageNumber!);

    if (response.responseCode == 200) {
      setWallpaperList(response.data!.photos!, response.data!.totalResults!);
    }
  }

  Future<void> searchWallpapers(String wallpaperName) async {
    pageNumber = pageNumber! + 1;

    HttpResponse<SearchWallpaperResponse> response =
        await _wallpaperServices.searchWallpapers(wallpaperName, pageNumber!);

    if (response.responseCode == 200) {
      setWallpaperList(response.data!.photos!, response.data!.totalResults!);
    }
  }

  void setWallpaperList(List<Photos> wallpaperPhotos, int totalNumber) {
    if (this.wallpaperPhotos == null) this.wallpaperPhotos = [];
    this.wallpaperPhotos!.addAll(wallpaperPhotos);
    this.totalNumber = totalNumber;

    notifyListeners();
  }
}
