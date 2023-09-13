import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Controllers/home_controller.dart';
import 'Controllers/favorite_controller.dart';
import 'Screens/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WallpaperController>(
          create: (context) => WallpaperController(),
        ),
        ChangeNotifierProvider<FavoriteController>(
          create: (context) => FavoriteController(),
        ),
      ],
      child: MaterialApp(
        title: 'Wallpaper App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
