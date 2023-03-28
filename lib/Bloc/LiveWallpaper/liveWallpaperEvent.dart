import 'package:flutter/cupertino.dart';

abstract class LiveWallpaperEvent {}

class GetAllLiveWallpaper extends LiveWallpaperEvent {}

class GetRandomLiveWallpaper extends LiveWallpaperEvent {}

class SearchLiveWallpaper extends LiveWallpaperEvent {
  final String string;
  final String orientation;
  SearchLiveWallpaper({@required this.string, @required this.orientation});
}

class CategoryLiveWallpaper extends LiveWallpaperEvent {
  final String category;
  CategoryLiveWallpaper({@required this.category});
}
