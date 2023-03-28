import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Theme/theme_cubit.dart';

import '../../Bloc/LiveWallpaper/liveWallpaperEvent.dart';
import '../../Bloc/LiveWallpaper/liveWallpaperState.dart';
import '../../Bloc/LiveWallpaper/randomLiveWallpaperBloc.dart';
import '../../Component/wallpaperGridView.dart';

class RandomLiveWallpaper extends StatefulWidget {
  @override
  _EditorChoiceState createState() => _EditorChoiceState();
}

class _EditorChoiceState extends State<RandomLiveWallpaper> {
  RandomLiveWallpaperBloc _wallpaperBloc;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    _wallpaperBloc = BlocProvider.of<RandomLiveWallpaperBloc>(context);
    _wallpaperBloc.add(GetRandomLiveWallpaper());

    return BlocBuilder<RandomLiveWallpaperBloc, LiveWallpaperState>(
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
