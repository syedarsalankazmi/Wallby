import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walla/Bloc/Wallpaper/categoryWallpaperBloc.dart';
import 'package:walla/Bloc/Wallpaper/randomWallpaperBlock.dart';
import 'package:walla/Bloc/Wallpaper/searchWallpaperBloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperBloc.dart';
import 'package:walla/Screens/HomePage.dart';
import 'package:flutter/services.dart';
import 'package:walla/Theme/theme_cubit.dart';
import 'package:walla/configs/constants.dart';

import 'Bloc/LiveWallpaper/categoryLiveWallpaperBloc.dart';
import 'Bloc/LiveWallpaper/liveWallpaperBloc.dart';
import 'Bloc/LiveWallpaper/randomLiveWallpaperBloc.dart';
import 'Bloc/LiveWallpaper/searchLiveWallpaperBlock.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WallpaperBloc>(
          create: (context) => WallpaperBloc(),
        ),
        BlocProvider<SearchWallpaperBloc>(
          create: (context) => SearchWallpaperBloc(),
        ),
        BlocProvider<CategoryWallpaperBloc>(
          create: (context) => CategoryWallpaperBloc(),
        ),
        BlocProvider<RandomWallpaperBloc>(
          create: (context) => RandomWallpaperBloc(),
        ),
        BlocProvider<LiveWallpaperBloc>(
          create: (context) => LiveWallpaperBloc(),
        ),
        BlocProvider<SearchLiveWallpaperBloc>(
          create: (context) => SearchLiveWallpaperBloc(),
        ),
        BlocProvider<CategoryLiveWallpaperBloc>(
          create: (context) => CategoryLiveWallpaperBloc(),
        ),
        BlocProvider<RandomLiveWallpaperBloc>(
          create: (context) => RandomLiveWallpaperBloc(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        )
      ],
      child: FutureBuilder<PackageInfo>(
        future: _getPackageInfo(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          if (snapshot.hasError) {
            return MyHomePage(AppConstants.defaultAppName);
          } else if (!snapshot.hasData) {
            return MyHomePage(AppConstants.defaultAppName);
          }

          AppConstants.appName = snapshot.data.appName;
          AppConstants.packageName = snapshot.data.packageName;
          AppConstants.buildNumber = snapshot.data.buildNumber;
          AppConstants.version = snapshot.data.version;

          FlutterNativeSplash.remove();

          return MyHomePage(AppConstants.appName);
        },
      ),
    );
  }
}
