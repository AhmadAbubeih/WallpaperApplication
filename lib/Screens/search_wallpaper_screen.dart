import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Utils/color_utils.dart';
import '../Controllers/home_controller.dart';
import '../Models/Api/wallpaper.dart';
import '../Utils/navigator_utils.dart';
import '../Widgets/custom_app_bar.dart';
import '../Widgets/home_wallpaper_widget.dart';
import '../Widgets/waiting_widget.dart';

class SearchWallpaperScreen extends StatefulWidget {
  const SearchWallpaperScreen({Key? key}) : super(key: key);

  @override
  _SearchWallpaperScreenState createState() => _SearchWallpaperScreenState();
}

class _SearchWallpaperScreenState extends State<SearchWallpaperScreen> {
  WallpaperController? _wallpaperController;

  ScrollController? _scrollController;

  String? searchText;

  @override
  void initState() {
    super.initState();

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
        onChangeSearchField: (value) {
          searchText = value;

          context.read<WallpaperController>().wallpaperPhotos = [];

          _wallpaperController!.searchWallpapers(searchText!);
        },
      ),
      body: Consumer<WallpaperController>(
          builder: (context, wallpaperController, child) {
        return wallpaperController.wallpaperPhotos == null
            ? const WaitingWidget()
            : SearchWallpaperGridView(
                scrollController: _scrollController,
                wallpaperPhotos: wallpaperController.wallpaperPhotos!,
              );
      }),
    ));
  }

  void initScrollControllerListener() {
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) {
        if (context.read<WallpaperController>().wallpaperPhotos!.length !=
            context.read<WallpaperController>().totalNumber!) {
          _wallpaperController!.searchWallpapers(searchText!);
        }
      }
    });
  }
}

class SearchWallpaperGridView extends StatelessWidget {
  final ScrollController? scrollController;
  final List<Photos>? wallpaperPhotos;

  const SearchWallpaperGridView(
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
                      ],
                    ),
                    const Center(child: WaitingWidget())
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
