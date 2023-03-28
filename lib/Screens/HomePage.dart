import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Component/cacheCleaner.dart';
import 'package:walla/Screens/Live/LiveWallpaper.dart';
import 'package:walla/Screens/Setting.dart';
import 'package:walla/Screens/StaticWallpaper.dart';
import 'package:walla/Theme/theme_cubit.dart';
import 'package:walla/configs/colors.dart';
import 'package:walla/configs/constants.dart';
import 'package:walla/configs/theme.dart';

import 'FavouriteWallpaper.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage(this.title);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    var tabs = [StaticWallpaper(), LiveWallpaper(), FavouriteWallpaper()];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName ?? AppConstants.defaultAppName,
      color: Colors.white,
      theme: isDark ? Themings.darkTheme : Themings.lightTheme,
      home: DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            tabController.addListener(() {
              setState(() {});
            });

            return Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor:
                      Color.fromARGB(255, 254, 213, 213).withOpacity(0.7),
                  tabs: [
                    Tab(
                        text: "Static",
                        icon: Icon(
                          Icons.wallpaper,
                          size: 25,
                        )),
                    Tab(
                        text: "Live",
                        icon: Icon(
                          Icons.slow_motion_video,
                          size: 25,
                        )),
                    Tab(
                        text: "Favourites",
                        icon: Icon(
                          Icons.favorite,
                          size: 25,
                        )),
                  ],
                ),
                backgroundColor: Colors.orange.shade800,
                elevation: 0.0,
                title: Text(
                  widget.title,
                  style: TextStyle(
                      fontFamily: 'CircularStd',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    themeCubit.toggleTheme();
                  },
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  icon: Icon(
                    isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                    color: isDark ? Colors.white : Colors.white,
                    size: 25,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: isDark ? Colors.white : Colors.white,
                    ),
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Setting()));
                    },
                  ),
                ],
              ),
              body: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  TabBarView(
                    children: tabs,
                  ),
                  CacheCleaner(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
