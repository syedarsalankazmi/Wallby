import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperEvent.dart';
import 'package:walla/Bloc/Wallpaper/wallpaperState.dart';
import 'package:http/http.dart' as http;
import 'package:walla/Model/staticWallpaperModel.dart';
import 'package:walla/const.dart';
import 'package:stream_transform/stream_transform.dart';

class RandomWallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  List<Wallpaper> _randomWallpapers = <Wallpaper>[];

  RandomWallpaperBloc() : super(WallpaperIsLoading()) {
    on<GetRandomWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      WallpaperEvent event, Emitter<WallpaperState> emit) async {
    if (event is GetRandomWallpaper) {
      emit(WallpaperIsLoading());
      try {
        if (_randomWallpapers.isEmpty) {
          var response = await http.get(
              Uri.parse(randomWallpaperEndPoint + "&" + perPageLimit),
              headers: {
                "Accept": "application/json",
                "Authorization": "$apiKey"
              });
          var data = jsonDecode(response.body)["photos"];
          _randomWallpapers = <Wallpaper>[];
          for (var i = 0; i < data.length; i++) {
            _randomWallpapers.add(Wallpaper.fromMap(data[i]));
          }
        }
        emit(WallpaperIsLoaded(_randomWallpapers));
      } on Exception catch (e) {
        emit(WallpaperIsNotLoaded(e.toString()));
      }
    }
  }
}
