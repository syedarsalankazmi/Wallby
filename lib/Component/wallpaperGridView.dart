import 'package:flutter/material.dart';
import 'package:walla/Component/wallpaperGridItemView.dart';

import '../configs/sharedPeferences.dart';

class WallpaperGridView extends StatefulWidget {
  const WallpaperGridView({
    Key key,
    @required this.state,
    @required this.isDark,
    @required this.onPressed,
    this.isFavSection = false,
  }) : super(key: key);

  final dynamic state;
  final bool isDark;
  final bool isFavSection;
  final Function onPressed;

  @override
  _WallpaperGridViewState createState() => _WallpaperGridViewState();
}

class _WallpaperGridViewState extends State<WallpaperGridView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = (size.width / 2);

    return FutureBuilder<List<dynamic>>(
      future: AppSharedPrefernces().getFavList(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            padding: EdgeInsets.all(5),
            itemCount: widget.state.getWallpaper.length,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: (itemWidth / itemHeight)),
            itemBuilder: (BuildContext context, int index) {
              dynamic wall = widget.state.getWallpaper[index];
              bool isFav =
                  snapshot.data.map((item) => item.id).contains(wall.id);
              return WallpaperGridIemView(
                  index: index,
                  wall: wall,
                  isDark: widget.isDark,
                  isFav: isFav,
                  isFavSection: widget.isFavSection,
                  onPressed: widget.onPressed);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
