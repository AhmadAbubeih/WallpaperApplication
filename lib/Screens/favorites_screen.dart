import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Controllers/favorite_controller.dart';
import 'package:wallpaper_app/Utils/color_utils.dart';
import 'package:wallpaper_app/Widgets/favorite_wallpaper_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
      ),
      body: const FavoriteWallpaperGridView(),
    ));
  }
}

class FavoriteWallpaperGridView extends StatelessWidget {
  const FavoriteWallpaperGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<FavoriteController>(
        builder: (context, favoriteController, child) {
      return favoriteController.favoriteWallpaper == null
          ? const SizedBox()
          : Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.007,
                      ),
                      Expanded(
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: size.width * 0.02,
                                    end: size.width * 0.02,
                                  ),
                                  child: AnimationLimiter(
                                    child: StaggeredGridView.countBuilder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,
                                      itemCount: favoriteController
                                          .favoriteWallpaper!.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                top: 7),
                                        child: AnimationConfiguration
                                            .staggeredGrid(
                                                columnCount: 2,
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 450),
                                                child: FavoriteWallpaperWidget(
                                                  wallpaperPhoto:
                                                      favoriteController
                                                              .favoriteWallpaper![
                                                          index],
                                                )),
                                      ),
                                      staggeredTileBuilder: (index) =>
                                          const StaggeredTile.fit(1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
