import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/Controllers/favorite_controller.dart';
import 'package:wallpaper_app/Controllers/home_controller.dart';
import 'package:wallpaper_app/Models/Api/wallpaper.dart';
import 'package:wallpaper_app/Utils/color_utils.dart';
import '../DatabaseHelper/wallpapers_database_helper.dart';
import '../Utils/navigator_utils.dart';
import '../Widgets/custom_app_bar.dart';
import '../Widgets/home_wallpaper_widget.dart';
import 'package:provider/provider.dart';
import '../Widgets/waiting_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WallpaperController? _wallpaperController;

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();

    getAllFavoritesWallpaperFromLocalDatabase();

    _scrollController = ScrollController();

    _wallpaperController = context.read<WallpaperController>();

    _wallpaperController!.getRandomWallpapers();

    initScrollControllerListener();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: primaryColor,
      appBar: CustomAppBar(
        preferredSizeHeight: size.height * 0.085,
        onTapSearchField: () {
          FocusScope.of(context).unfocus();

          NavigatorUtils.navigateToSearchWallpaperScreen(context);
        },
      ),
      body: Consumer<WallpaperController>(
          builder: (context, wallpaperController, child) {
        return wallpaperController.wallpaperPhotos == null
            ? const WaitingWidget()
            : HomeWallpaperGridView(
                scrollController: _scrollController,
                wallpaperPhotos: wallpaperController.wallpaperPhotos!,
              );
      }),
    ));
  }

  void getAllFavoritesWallpaperFromLocalDatabase() async {
    final database = WallpapersDatabaseHelper();

    final images = await database.getAllFavoriteWallpapers();

    context.read<FavoriteController>().favoriteWallpaper = images.toList();
  }

  void initScrollControllerListener() {
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) {
        if (context.read<WallpaperController>().wallpaperPhotos!.length !=
            context.read<WallpaperController>().totalNumber!) {
          _wallpaperController!.getRandomWallpapers();
        }
      }
    });
  }
}

class HomeWallpaperGridView extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Photos>? wallpaperPhotos;

  const HomeWallpaperGridView(
      {Key? key, this.scrollController, this.wallpaperPhotos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.007,
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
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
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              itemCount: wallpaperPhotos!.length,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 7),
                                child: AnimationConfiguration.staggeredGrid(
                                  columnCount: 2,
                                  position: index,
                                  duration: const Duration(milliseconds: 450),
                                  child: HomeWallpaperWidget(
                                    wallpaperPhoto: wallpaperPhotos![index],
                                  ),
                                ),
                              ),
                              staggeredTileBuilder: (index) =>
                                  const StaggeredTile.fit(1),
                            ),
                          ),
                        ),
                        const Center(child: WaitingWidget())
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
  }
}
