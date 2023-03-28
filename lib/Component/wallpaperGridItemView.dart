import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walla/Screens/Live/DetailLiveWallpaper.dart';
import 'package:walla/configs/colors.dart';
import 'package:walla/configs/sharedPeferences.dart';

import '../Model/staticWallpaperModel.dart';
import '../Screens/Detail.dart';

class WallpaperGridIemView extends StatefulWidget {
  const WallpaperGridIemView({
    @required this.index,
    @required this.wall,
    @required this.isDark,
    @required this.onPressed,
    @required this.isFav,
    this.isFavSection = false,
    Key key,
  }) : super(key: key);

  final int index;
  final dynamic wall;
  final bool isDark;
  final Function onPressed;
  final bool isFav;
  final bool isFavSection;

  @override
  State<WallpaperGridIemView> createState() => _WallpaperGridIemViewState();
}

class _WallpaperGridIemViewState extends State<WallpaperGridIemView>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  int counter = 0;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);
  }

  void openPage(dynamic wallpaper) {
    counter++;
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => widget.wall is Wallpaper
              ? Detail(
                  wallpaper: wallpaper,
                  isPortrait: true,
                )
              : DetailLiveWallpaper(
                  videoFile: wallpaper.videoFiles[0],
                )),
    );
  }

  Future<void> showAd(dynamic wallpaper) async {
    counter = 0;
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => widget.wall is Wallpaper
            ? Detail(
                wallpaper: wallpaper,
                isPortrait: true,
              )
            : DetailLiveWallpaper(
                videoFile: wallpaper.videoFiles[0],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        counter == 2 ? showAd(widget.wall) : openPage(widget.wall);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FadeInImage.assetNetwork(
                image: widget.wall is Wallpaper
                    ? widget.wall.src.portrait
                    : widget.wall.videoPictures[0].picture,
                fit: BoxFit.cover,
                placeholder: widget.isDark
                    ? "assets/icon/darkIcon.png"
                    : "assets/icon/icon.png",
                imageScale: 1,
                placeholderFit: BoxFit.cover),
          ),
          Container(
            margin: EdgeInsets.all(15),
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isFavSection
                    ? Icon(
                        widget.wall is Wallpaper
                            ? Icons.wallpaper
                            : Icons.slow_motion_video,
                        size: 25,
                        color: Colors.white.withAlpha(200),
                      )
                    : SizedBox(),
                GestureDetector(
                  onTap: () {
                    _animationController
                        .reverse()
                        .then((value) => _animationController.forward());

                    AppSharedPrefernces().getFavList().then(
                          (value) => {
                            if (value
                                .map((item) => item.id)
                                .contains(widget.wall.id))
                              value.removeWhere(
                                  (item) => item.id == widget.wall.id)
                            else
                              value.add(widget.wall),
                            AppSharedPrefernces()
                                .saveFavList(value)
                                .then((value) => {widget.onPressed()}),
                          },
                        );
                  },
                  child: ScaleTransition(
                      scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.easeOut)),
                      child: widget.isFav
                          ? Icon(
                              Icons.favorite,
                              size: 25,
                              color: Colors.red.withAlpha(200),
                            )
                          : Icon(Icons.favorite_border,
                              size: 25, color: AppColors.black.withAlpha(200))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
