import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperEvent.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import 'package:http/http.dart' as http;
import 'package:walla/Model/staticWallpaperModel.dart';
import 'package:walla/const.dart';
import 'package:stream_transform/stream_transform.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  List<Wallpaper> _editorChoiceWallpapers = <Wallpaper>[];

  WallpaperBloc() : super(WallpaperIsLoading()) {
    on<GetAllWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      WallpaperEvent event, Emitter<WallpaperState> emit) async {
    if (event is GetAllWallpaper) {
      emit(WallpaperIsLoading());
      try {
        if (_editorChoiceWallpapers.isEmpty) {
          var response = await http.get(
              Uri.parse(editorChoiceEndPoint + "?" + perPageLimit),
              headers: {
                "Accept": "application/json",
                "Authorization": "$apiKey"
              });
          var data = jsonDecode(response.body)["photos"];
          _editorChoiceWallpapers = <Wallpaper>[];
          for (var i = 0; i < data.length; i++) {
            _editorChoiceWallpapers.add(Wallpaper.fromMap(data[i]));
          }
        }
        emit(WallpaperIsLoaded(_editorChoiceWallpapers));
      } on Exception catch (e) {
        emit(WallpaperIsNotLoaded(e.toString()));
      }
    }
  }
}
