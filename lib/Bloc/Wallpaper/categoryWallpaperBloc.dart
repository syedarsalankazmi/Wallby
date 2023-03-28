import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperEvent.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import 'package:walla/Model/staticWallpaperModel.dart';
import 'package:http/http.dart' as http;
import 'package:walla/const.dart';
import 'package:stream_transform/stream_transform.dart';

class CategoryWallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  List<Wallpaper> _categoryWallpaper = <Wallpaper>[];
  String searchedString;

  CategoryWallpaperBloc() : super(CategoryWallpaperIsLoading()) {
    on<CategoryWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      WallpaperEvent event, Emitter<WallpaperState> emit) async {
    if (event is CategoryWallpaper) {
      if (event.category != searchedString) {
        searchedString = event.category;
        emit(CategoryWallpaperIsLoading());
        try {
          var response = await http.get(
              Uri.parse(searchEndPoint + event.category + "&" + perPageLimit),
              headers: {
                "Accept": "application/json",
                "Authorization": "$apiKey"
              });
          var data = jsonDecode(response.body)["photos"];
          _categoryWallpaper = <Wallpaper>[];
          for (var i = 0; i < data.length; i++) {
            _categoryWallpaper.add(Wallpaper.fromMap(data[i]));
          }
          emit(CategoryWallpaperIsLoaded(_categoryWallpaper));
        } on Exception catch (e) {
          emit(CategoryWallpaperIsNotLoaded(e.toString()));
        }
      }
    }
  }
}
