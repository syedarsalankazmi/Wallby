import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/LiveWallpaper/liveWallpaperBloc.dart';
import 'package:walla/Theme/theme_cubit.dart';

import '../../Bloc/LiveWallpaper/liveWallpaperEvent.dart';
import '../../Bloc/LiveWallpaper/liveWallpaperState.dart';
import '../../Component/wallpaperGridView.dart';

class LivePopular extends StatefulWidget {
  @override
  _LivePopularState createState() => _LivePopularState();
}

class _LivePopularState extends State<LivePopular> {
  LiveWallpaperBloc _wallpaperBloc;

  @override
  Widget build(BuildContext context) {
    _wallpaperBloc = BlocProvider.of<LiveWallpaperBloc>(context);
    _wallpaperBloc.add(GetAllLiveWallpaper());

    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return BlocBuilder<LiveWallpaperBloc, LiveWallpaperState>(
      builder: (BuildContext context, state) {
        if (state is LiveWallpaperIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LiveWallpaperIsLoaded) {
          return WallpaperGridView(
              state: state,
              isDark: isDark,
              onPressed: () {
                setState(() {});
              });
        } else if (state is LiveWallpaperIsNotLoaded) {
          return Center(
            child: Text("Error Loading Wallpapers."),
          );
        } else {
          return Text("Something Went Worng :(");
        }
      },
    );
  }
}
