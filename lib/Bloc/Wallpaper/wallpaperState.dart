import 'package:walla/Model/staticWallpaperModel.dart';

abstract class WallpaperState {}

class WallpaperIsLoading extends WallpaperState {}

class WallpaperIsLoaded extends WallpaperState {
  final List<Wallpaper> _wallpaper;
  WallpaperIsLoaded(this._wallpaper);
  List<Wallpaper> get getWallpaper => _wallpaper;
}

class FavWallpaperIsLoaded extends WallpaperState {
  final List<dynamic> _wallpaper;
  FavWallpaperIsLoaded(this._wallpaper);
  List<dynamic> get getWallpaper => _wallpaper;
}

class WallpaperIsNotLoaded extends WallpaperState {
  final String _exception;
  WallpaperIsNotLoaded(this._exception) {
    print(_exception);
  }
}

class SearchWallpaperNotSearched extends WallpaperState {}

class SearchWallpaperIsLoading extends WallpaperState {}

class SearchWallpaperIsNotLoaded extends WallpaperState {
  final String _exception;
  SearchWallpaperIsNotLoaded(this._exception) {
    print(_exception);
  }
}

class SearchWallpaperIsLoaded extends WallpaperState {
  final List<Wallpaper> _wallpaper;
  SearchWallpaperIsLoaded(this._wallpaper);
  List<Wallpaper> get getWallpaper => _wallpaper;
}

class CategoryWallpaperNotSearched extends WallpaperState {}

class CategoryWallpaperIsLoading extends WallpaperState {}

class CategoryWallpaperIsLoaded extends WallpaperState {
  final List<Wallpaper> _wallpaper;
  CategoryWallpaperIsLoaded(this._wallpaper);
  List<Wallpaper> get getWallpaper => _wallpaper;
}

class CategoryWallpaperIsNotLoaded extends WallpaperState {
  final String _exception;
  CategoryWallpaperIsNotLoaded(this._exception) {
    print(_exception);
  }
}
