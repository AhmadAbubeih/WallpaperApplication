import 'dart:io';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/Controllers/favorite_controller.dart';
import 'package:wallpaper_app/Models/Api/wallpaper.dart';
import '../Utils/color_utils.dart';
import 'package:provider/provider.dart';
import '../Utils/navigator_utils.dart';

class WallpaperDetailsScreen extends StatefulWidget {
  final Photos? wallpaperPhoto;

  const WallpaperDetailsScreen({
    Key? key,
    this.wallpaperPhoto,
  }) : super(key: key);

  @override
  _WallpaperDetailsScreenState createState() => _WallpaperDetailsScreenState();
}

class _WallpaperDetailsScreenState extends State<WallpaperDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: size.width * 0.025),
            child: InkWell(
                onTap: () {
                  NavigatorUtils.navigateToFavoritesScreen(context);
                },
                child: Icon(Icons.favorite, size: size.height * 0.046)),
          ),
        ],
      ),
      body: WallpaperDetailsWidget(wallpaperPhoto: widget.wallpaperPhoto),
    ));
  }
}

class WallpaperDetailsWidget extends StatelessWidget {
  final Photos? wallpaperPhoto;

  const WallpaperDetailsWidget({Key? key, this.wallpaperPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                Center(
                  child: Image.network(
                    wallpaperPhoto!.src!.large!,
                    height: size.height * 0.66,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: size.height * 0.63,
                  start: size.width * 0.04,
                  end: size.width * 0.04),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: size.height * 0.065,
                  height: size.height * 0.065,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: secondaryColor),
                  child: InkWell(
                    onTap: () {
                      if (context
                                  .read<FavoriteController>()
                                  .favoriteWallpaper !=
                              null &&
                          context
                                  .read<FavoriteController>()
                                  .favoriteWallpaper !=
                              null &&
                          context
                              .read<FavoriteController>()
                              .favoriteWallpaper!
                              .map((e) => e.id)
                              .toList()
                              .contains(wallpaperPhoto!.id)) {
                        context
                            .read<FavoriteController>()
                            .removeWallpaperPhotoFromFavorite(
                                wallpaperPhoto!.id!);
                      } else {
                        context
                            .read<FavoriteController>()
                            .addWallpaperPhotoToFavorite(wallpaperPhoto!.id!,
                                wallpaperPhoto!.src!.tiny!);
                      }
                    },
                    child: Icon(
                      context.watch<FavoriteController>().favoriteWallpaper !=
                                  null &&
                              context
                                  .watch<FavoriteController>()
                                  .favoriteWallpaper!
                                  .map((e) => e.id)
                                  .toList()
                                  .contains(wallpaperPhoto!.id)
                          ? Icons.favorite_outlined
                          : Icons.favorite_border,
                      size: size.height * 0.035,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.0675),
        Center(
          child: SizedBox(
              width: size.width * 0.6,
              height: size.height * 0.06,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    downloadImage(context);
                  },
                  child: Text(
                    "Download",
                    style: TextStyle(
                        fontSize: size.height * 0.022, color: primaryColor),
                  ))),
        ),
      ],
    );
  }

  void downloadImage(context) async {
    try {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.storage].request();

      if (statuses[Permission.storage]!.isGranted) {
        Directory? directory;

        if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        } else {
          directory = await DownloadsPathProvider.downloadsDirectory;
        }

        if (directory != null) {
          String saveName = wallpaperPhoto!.src!.large!
              .split("?")
              .first
              .split("${wallpaperPhoto!.id}/")
              .last;

          String savePath = "${directory.path}/$saveName";

          try {
            await Dio().download(wallpaperPhoto!.src!.large!, savePath,
                onReceiveProgress: (received, total) {});

            showSnackBar(context, "Wallpaper image downloaded");
          } on DioError catch (e) {
            showSnackBar(context, "Error : $e");
          }
        }
      } else {}
    } catch (e) {
      showSnackBar(context, "Error : $e");
    }
  }

  void showSnackBar(context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: Text(message, style: TextStyle(color: Colors.black)),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.black,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
