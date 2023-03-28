import 'package:walla/Model/liveWallpaperModel.dart';

abstract class LiveWallpaperState {}

class LiveWallpaperIsLoading extends LiveWallpaperState {}

class LiveWallpaperIsLoaded extends LiveWallpaperState {
  final List<LiveWallpaperModel> _wallpaper;
  LiveWallpaperIsLoaded(this._wallpaper);
  List<LiveWallpaperModel> get getWallpaper => _wallpaper;
}

class LiveWallpaperIsNotLoaded extends LiveWallpaperState {
  final String _exception;
  LiveWallpaperIsNotLoaded(this._exception) {
    print(_exception);
  }
}

class SearchLiveWallpaperNotSearched extends LiveWallpaperState {}

class SearchLiveWallpaperIsLoading extends LiveWallpaperState {}

class SearchLiveWallpaperIsNotLoaded extends LiveWallpaperState {
  final String _exception;
  SearchLiveWallpaperIsNotLoaded(this._exception) {
    print(_exception);
  }
}

class SearchLiveWallpaperIsLoaded extends LiveWallpaperState {
  final List<LiveWallpaperModel> _wallpaper;
  SearchLiveWallpaperIsLoaded(this._wallpaper);
  List<LiveWallpaperModel> get getWallpaper => _wallpaper;
}

class CategoryLiveWallpaperNotSearched extends LiveWallpaperState {}

class CategoryLiveWallpaperIsLoading extends LiveWallpaperState {}

class CategoryLiveWallpaperIsLoaded extends LiveWallpaperState {
  final List<LiveWallpaperModel> _wallpaper;
  CategoryLiveWallpaperIsLoaded(this._wallpaper);
  List<LiveWallpaperModel> get getWallpaper => _wallpaper;
}

class CategoryLiveWallpaperIsNotLoaded extends LiveWallpaperState {
  final String _exception;
  CategoryLiveWallpaperIsNotLoaded(this._exception) {
    print(_exception);
  }
}
