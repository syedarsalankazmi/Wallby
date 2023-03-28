import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperEvent.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import 'package:walla/Model/staticWallpaperModel.dart';
import 'package:walla/const.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

class SearchWallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  List<Wallpaper> _searchWallpaper = <Wallpaper>[];
  String searchedString;
  String searchedOrientation;

  SearchWallpaperBloc() : super(SearchWallpaperNotSearched()) {
    on<SearchWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      WallpaperEvent event, Emitter<WallpaperState> emit) async {
    if (event is SearchWallpaper) {
      if (event.string != searchedString ||
          event.orientation != searchedOrientation) {
        searchedString = event.string;
        searchedOrientation = event.orientation;
        emit(SearchWallpaperIsLoading());
        try {
          String orientation = "";
          if (event.orientation != "All") {
            orientation = "&orientation=${event.orientation}";
          }
          String url =
              searchEndPoint + event.string + "&" + perPageLimit + orientation;
          var response = await http.get(Uri.parse(url), headers: {
            "Accept": "application/json",
            "Authorization": "$apiKey"
          });
          var data = jsonDecode(response.body)["photos"];
          _searchWallpaper = <Wallpaper>[];
          for (var i = 0; i < data.length; i++) {
            _searchWallpaper.add(Wallpaper.fromMap(data[i]));
          }
          emit(SearchWallpaperIsLoaded(_searchWallpaper));
        } on Exception catch (e) {
          emit(SearchWallpaperIsNotLoaded(e.toString()));
        }
      }
    }
  }
}
