import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/categoryWallpaperBloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperEvent.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import 'package:walla/Model/staticWallpaperModel.dart';
import 'package:walla/Screens/Detail.dart';
import 'package:walla/Theme/theme_cubit.dart';

import '../Component/wallpaperGridView.dart';

class Category extends StatefulWidget {
  final String category;
  Category({@required this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  CategoryWallpaperBloc categoryWallpaperBloc;

  int counter = 0;
  void openPage(Wallpaper wallpaper) {
    counter++;
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Detail(
          wallpaper: wallpaper,
          isPortrait: true,
        ),
      ),
    );
  }

  void showAd(Wallpaper wallpaper) {
    print("inside");
    counter = 0;
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Detail(
          wallpaper: wallpaper,
          isPortrait: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    categoryWallpaperBloc = BlocProvider.of<CategoryWallpaperBloc>(context);
    categoryWallpaperBloc.add(CategoryWallpaper(category: widget.category));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        elevation: 0.0,
        title: Text(
          widget.category,
          style: TextStyle(
            fontFamily: 'CircularStd',
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryWallpaperBloc, WallpaperState>(
        builder: (BuildContext context, state) {
          if (state is CategoryWallpaperIsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryWallpaperIsLoaded) {
            return WallpaperGridView(
                state: state,
                isDark: isDark,
                onPressed: () {
                  setState(() {});
                });
          } else if (state is CategoryWallpaperIsNotLoaded) {
            return Center(
              child: Text("Error Loading Wallpapers."),
            );
          } else {
            return Text("Something Went Worng :(");
          }
        },
      ),
    );
  }
}
