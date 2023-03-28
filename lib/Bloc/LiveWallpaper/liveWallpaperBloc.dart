import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:walla/Model/liveWallpaperModel.dart';
import 'package:walla/const.dart';
import 'package:stream_transform/stream_transform.dart';

import 'liveWallpaperEvent.dart';
import 'liveWallpaperState.dart';

class LiveWallpaperBloc extends Bloc<LiveWallpaperEvent, LiveWallpaperState> {
  List<LiveWallpaperModel> _popularLiveWallpapers = <LiveWallpaperModel>[];

  LiveWallpaperBloc() : super(LiveWallpaperIsLoading()) {
    on<GetAllLiveWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      LiveWallpaperEvent event, Emitter<LiveWallpaperState> emit) async {
    if (event is GetAllLiveWallpaper) {
      emit(LiveWallpaperIsLoading());
      try {
        if (_popularLiveWallpapers.isEmpty) {
          var response = await http.get(
              Uri.parse(popularLiveWallpaperEndPoint + "?" + perPageLimit),
              headers: {
                "Accept": "application/json",
                "Authorization": "$apiKey"
              });
          var data = jsonDecode(response.body)["videos"];
          _popularLiveWallpapers = <LiveWallpaperModel>[];
          for (var i = 0; i < data.length; i++) {
            _popularLiveWallpapers.add(LiveWallpaperModel.fromMap(data[i]));
          }
        }
        emit(LiveWallpaperIsLoaded(_popularLiveWallpapers));
      } on Exception catch (e) {
        emit(LiveWallpaperIsNotLoaded(e.toString()));
      }
    }
  }
}
