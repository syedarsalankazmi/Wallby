import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Theme/theme_cubit.dart';

import '../../Bloc/LiveWallpaper/categoryLiveWallpaperBloc.dart';
import '../../Bloc/LiveWallpaper/liveWallpaperEvent.dart';
import '../../Bloc/LiveWallpaper/liveWallpaperState.dart';
import '../../Component/wallpaperGridView.dart';

class LiveCategory extends StatefulWidget {
  final String category;
  LiveCategory({@required this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<LiveCategory> {
  CategoryLiveWallpaperBloc categoryWallpaperBloc;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    categoryWallpaperBloc = BlocProvider.of<CategoryLiveWallpaperBloc>(context);
    categoryWallpaperBloc.add(CategoryLiveWallpaper(category: widget.category));

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
      body: BlocBuilder<CategoryLiveWallpaperBloc, LiveWallpaperState>(
        builder: (BuildContext context, state) {
          if (state is CategoryLiveWallpaperIsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CategoryLiveWallpaperIsLoaded) {
            return WallpaperGridView(
                state: state,
                isDark: isDark,
                onPressed: () {
                  setState(() {});
                });
          } else if (state is CategoryLiveWallpaperIsNotLoaded) {
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
