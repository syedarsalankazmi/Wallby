import 'package:flutter/cupertino.dart';

abstract class WallpaperEvent {}

class GetAllWallpaper extends WallpaperEvent {}

class GetRandomWallpaper extends WallpaperEvent {}

class SearchWallpaper extends WallpaperEvent {
  final String string;
  final String orientation;
  SearchWallpaper({@required this.string, @required this.orientation});
}

class CategoryWallpaper extends WallpaperEvent {
  final String category;
  CategoryWallpaper({@required this.category});
}
