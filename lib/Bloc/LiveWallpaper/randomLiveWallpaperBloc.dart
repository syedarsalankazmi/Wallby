import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:walla/const.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../Model/liveWallpaperModel.dart';
import 'liveWallpaperEvent.dart';
import 'liveWallpaperState.dart';

class RandomLiveWallpaperBloc
    extends Bloc<LiveWallpaperEvent, LiveWallpaperState> {
  List<LiveWallpaperModel> _randomWallpapers = <LiveWallpaperModel>[];

  RandomLiveWallpaperBloc() : super(LiveWallpaperIsLoading()) {
    on<GetRandomLiveWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      LiveWallpaperEvent event, Emitter<LiveWallpaperState> emit) async {
    if (event is GetRandomLiveWallpaper) {
      emit(LiveWallpaperIsLoading());
      try {
        if (_randomWallpapers.isEmpty) {
          var response = await http.get(
              Uri.parse(randomLiveWallpaperEndPoint + "&" + perPageLimit),
              headers: {
                "Accept": "application/json",
                "Authorization": "$apiKey"
              });
          var data = jsonDecode(response.body)["videos"];
          _randomWallpapers = <LiveWallpaperModel>[];
          for (var i = 0; i < data.length; i++) {
            _randomWallpapers.add(LiveWallpaperModel.fromMap(data[i]));
          }
        }
        emit(LiveWallpaperIsLoaded(_randomWallpapers));
      } on Exception catch (e) {
        emit(LiveWallpaperIsNotLoaded(e.toString()));
      }
    }
  }
}
