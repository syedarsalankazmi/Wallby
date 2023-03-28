import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import '../Component/noFavourites.dart';
import '../Component/wallpaperGridView.dart';
import '../Theme/theme_cubit.dart';
import '../configs/sharedPeferences.dart';

class FavouriteWallpaper extends StatefulWidget {
  @override
  _StaticWallpaperState createState() => _StaticWallpaperState();
}

class _StaticWallpaperState extends State<FavouriteWallpaper> {
  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return FutureBuilder<List<dynamic>>(
      future: AppSharedPrefernces().getFavList(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
            return WallpaperGridView(
                state: FavWallpaperIsLoaded(snapshot.data),
                isDark: isDark,
                isFavSection: true,
                onPressed: () {
                  setState(() {});
                });
          } else
            return NoFavourites(isDark: isDark);
        } else {
          return NoFavourites(isDark: isDark);
        }
      },
    );
  }
}
