import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Controllers/home_controller.dart';
import 'package:wallpaper_app/Screens/search_wallpaper_screen.dart';
import 'package:wallpaper_app/Screens/wallpaper_details_screen.dart';

import '../Models/Api/wallpaper.dart';
import '../Screens/favorites_screen.dart';

class NavigatorUtils {
  static void navigateToSearchWallpaperScreen(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => WallpaperController(),
                child: const SearchWallpaperScreen())));
  }

  static void navigateToWallpaperDetailsScreen(
      context, Photos? wallpaperPhoto) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WallpaperDetailsScreen(
                  wallpaperPhoto: wallpaperPhoto,
                )));
  }

  static void navigateToFavoritesScreen(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FavoritesScreen()));
  }
}
