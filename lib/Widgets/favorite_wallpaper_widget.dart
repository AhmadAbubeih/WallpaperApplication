import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wallpaper_app/Models/Api/favorite_wallpaper.dart';
import 'package:wallpaper_app/Models/Api/wallpaper.dart';
import 'package:wallpaper_app/Utils/navigator_utils.dart';

import '../Controllers/favorite_controller.dart';
import 'package:provider/provider.dart';

class FavoriteWallpaperWidget extends StatelessWidget {
  final FavoriteWallpaper? wallpaperPhoto;

  const FavoriteWallpaperWidget({Key? key, this.wallpaperPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaleAnimation(
      child: FadeInAnimation(
        child: Padding(
          padding:
              const EdgeInsetsDirectional.only(start: 5, end: 5, bottom: 10),
          child: InkWell(
            onTap: () {},
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Image.network(
                              wallpaperPhoto!.photoUrl!,
                              height: size.height * 0.245,
                              width: size.width,
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<FavoriteController>()
                                .removeWallpaperPhotoFromFavorite(
                                    wallpaperPhoto!.id!);
                          },
                          child: Icon(Icons.remove_circle,
                              color: Colors.red, size: size.height * 0.035),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
