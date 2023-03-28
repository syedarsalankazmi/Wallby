import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:walla/Screens/Live/LivePopular.dart';
import '../../Theme/theme_cubit.dart';
import '../../configs/colors.dart';
import 'package:walla/Screens/CategoryList.dart' as categoryScreen;

import 'RandomLiveWallpaper.dart';
import 'SearchLiveWallpaper.dart';

class LiveWallpaper extends StatefulWidget {
  @override
  _StaticWallpaperState createState() => _StaticWallpaperState();
}

class _StaticWallpaperState extends State<LiveWallpaper>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  PageController controller = PageController();
  List<GButton> tabs = [];
  var padding = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  var borderRadius = BorderRadius.all(Radius.circular(5));
  double gap = 10;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Builder(
      builder: (context) => Scaffold(
        extendBody: true,
        body: liveWallpaper(),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: isDark
                        ? Colors.black.withAlpha(50)
                        : AppColors.black.withAlpha(50)),
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 20,
                      blurRadius: 50,
                      color: Colors.black.withOpacity(.10),
                      offset: Offset(20, 20))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: new Container(
                height: 50.0,
                child: GNav(
                    tabs: [
                      GButton(
                        borderRadius: borderRadius,
                        gap: gap,
                        iconActiveColor: Colors.orange.shade700,
                        iconColor: Colors.orangeAccent.withOpacity(.8),
                        backgroundColor: Colors.orangeAccent.withOpacity(.2),
                        iconSize: 24,
                        padding: padding,
                        icon: Icons.verified_user,
                        text: "Popular",
                        textStyle: Theme.of(context).textTheme.bodySmall.apply(
                            color: Colors.orange.shade700, fontWeightDelta: 3),
                      ),
                      GButton(
                        borderRadius: borderRadius,
                        gap: gap,
                        iconActiveColor: Colors.blue.shade700,
                        iconColor: Colors.blueAccent.withOpacity(.8),
                        backgroundColor: Colors.blueAccent.withOpacity(.2),
                        iconSize: 24,
                        padding: padding,
                        icon: Icons.category,
                        text: "Categories",
                        textStyle: Theme.of(context).textTheme.bodySmall.apply(
                            color: Colors.blue.shade700, fontWeightDelta: 3),
                      ),
                      GButton(
                        borderRadius: borderRadius,
                        gap: gap,
                        iconActiveColor: Colors.green.shade700,
                        iconColor: Colors.greenAccent.withOpacity(.8),
                        backgroundColor: Colors.greenAccent.withOpacity(.2),
                        iconSize: 24,
                        padding: padding,
                        icon: Icons.shuffle,
                        text: "Random",
                        textStyle: Theme.of(context).textTheme.bodySmall.apply(
                            color: Colors.green.shade700, fontWeightDelta: 3),
                      ),
                      GButton(
                        borderRadius: borderRadius,
                        gap: gap,
                        iconActiveColor: Colors.yellow.shade700,
                        iconColor: Colors.yellowAccent.withOpacity(.8),
                        backgroundColor: Colors.yellowAccent.withOpacity(.2),
                        iconSize: 24,
                        padding: padding,
                        icon: Icons.search,
                        text: "Search",
                        textStyle: Theme.of(context).textTheme.bodySmall.apply(
                            color: Colors.yellow.shade700, fontWeightDelta: 3),
                      )
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      controller.jumpToPage(index);
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PageView liveWallpaper() {
    return PageView.builder(
      onPageChanged: (page) {
        setState(() {
          _selectedIndex = page;
        });
      },
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        return getScreen(index);
      },
      itemCount: 4,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

getScreen(int selectedIndex) {
  if (selectedIndex == 0) {
    return LivePopular();
  } else if (selectedIndex == 1) {
    return categoryScreen.CategoryList(false);
  } else if (selectedIndex == 2) {
    return RandomLiveWallpaper();
  } else if (selectedIndex == 3) {
    return SearchLive();
  }
}
