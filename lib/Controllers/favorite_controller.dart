import 'package:flutter/material.dart';
import 'package:wallpaper_app/Models/Api/favorite_wallpaper.dart';
import '../DatabaseHelper/wallpapers_database_helper.dart';

class FavoriteController with ChangeNotifier {
  List<FavoriteWallpaper>? favoriteWallpaper;

  final database = WallpapersDatabaseHelper();

  void addWallpaperPhotoToFavorite(int id, String photoUrl) {
    favoriteWallpaper ??= [];

    FavoriteWallpaper favoriteWallpaperPhoto =
        FavoriteWallpaper(id: id, photoUrl: photoUrl);

    favoriteWallpaper!.add(favoriteWallpaperPhoto);

    database.insertWallpaperToFavorite(favoriteWallpaperPhoto);

    notifyListeners();
  }

  void removeWallpaperPhotoFromFavorite(int id) {
    favoriteWallpaper!.removeWhere((element) => element.id == id);

    database.removeWallpaperToFavorite(id);

    notifyListeners();
  }
}
