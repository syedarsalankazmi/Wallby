import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/liveWallpaperModel.dart';
import '../Model/staticWallpaperModel.dart';

class AppSharedPrefernces {
  static const String ThemeKey = "isNightMode";

  void setNightMode(bool isNightMode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(ThemeKey, isNightMode);
  }

  Future<bool> getNightMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(ThemeKey);
  }

  Future<bool> saveFavList(List<dynamic> favWallpapers) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favList = List.empty(growable: true);

    for (var item in favWallpapers) {
      favList.add(jsonEncode(item));
    }

    return prefs.setStringList('favourites', favList);
  }

  Future<List<dynamic>> getFavList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favList =
        (prefs.getStringList('favourites') ?? List.empty(growable: true));

    List<dynamic> favWallpapers = List.empty(growable: true);

    for (var item in favList) {
      if (item.contains("video_files")) {
        favWallpapers.add(LiveWallpaperModel.fromMap(jsonDecode(item)));
      } else {
        favWallpapers.add(Wallpaper.fromMap(jsonDecode(item)));
      }
    }

    debugPrint("favWallpapers size: " + favWallpapers.length.toString());
    return favWallpapers;
  }
}
