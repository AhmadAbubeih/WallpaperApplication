import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wallpaper_app/Models/Api/wallpaper.dart';
import 'package:wallpaper_app/Utils/navigator_utils.dart';

class HomeWallpaperWidget extends StatelessWidget {
  final Photos? wallpaperPhoto;

  const HomeWallpaperWidget({Key? key, this.wallpaperPhoto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaleAnimation(
      child: FadeInAnimation(
        child: Padding(
          padding:
              const EdgeInsetsDirectional.only(start: 5, end: 5, bottom: 10),
          child: InkWell(
            onTap: () {
              NavigatorUtils.navigateToWallpaperDetailsScreen(
                  context, wallpaperPhoto!);
            },
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Image.network(
                          wallpaperPhoto!.src!.tiny!,
                          height: size.height * 0.245,
                          width: size.width,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
