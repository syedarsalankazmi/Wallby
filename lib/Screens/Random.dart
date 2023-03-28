import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/randomWallpaperBlock.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperEvent.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import 'package:walla/Theme/theme_cubit.dart';

import '../Component/wallpaperGridView.dart';

class RandomWallpaper extends StatefulWidget {
  @override
  _EditorChoiceState createState() => _EditorChoiceState();
}

class _EditorChoiceState extends State<RandomWallpaper> {
  RandomWallpaperBloc _wallpaperBloc;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    _wallpaperBloc = BlocProvider.of<RandomWallpaperBloc>(context);
    _wallpaperBloc.add(GetRandomWallpaper());

    return BlocBuilder<RandomWallpaperBloc, WallpaperState>(
      builder: (BuildContext context, state) {
        if (state is WallpaperIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WallpaperIsLoaded) {
          return WallpaperGridView(
              state: state,
              isDark: isDark,
              onPressed: () {
                setState(() {});
              });
        } else if (state is WallpaperIsNotLoaded) {
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
