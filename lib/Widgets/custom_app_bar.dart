import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wallpaper_app/Utils/navigator_utils.dart';

import '../Utils/color_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? onChangeSearchField;
  final Function? onTapSearchField;
  final double? preferredSizeHeight;

  const CustomAppBar(
      {Key? key,
      this.onChangeSearchField,
      this.onTapSearchField,
      required this.preferredSizeHeight})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(preferredSizeHeight!);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AppBar(
      toolbarHeight: size.height * 0.085,
      centerTitle: true,
      elevation: 0,
      backgroundColor: secondaryColor,
      title: SizedBox(
        height: size.height * 0.052,
        width: double.infinity,
        child: Material(
          elevation: 3.0,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: TextField(
            cursorColor: primaryColor,
            onTap: () {
              if (onTapSearchField != null) onTapSearchField!();
            },
            onChanged: (value) {
              if (onChangeSearchField != null) onChangeSearchField!(value);
            },
            decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(
                  Icons.search,
                  size: size.height * 0.04,
                  color: secondaryColor,
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: size.height * 0.013)),
          ),
        ),
      ),
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
    );
  }
}
