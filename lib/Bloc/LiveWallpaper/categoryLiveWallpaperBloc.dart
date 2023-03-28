import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:walla/const.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../Model/liveWallpaperModel.dart';
import 'liveWallpaperEvent.dart';
import 'liveWallpaperState.dart';

class CategoryLiveWallpaperBloc
    extends Bloc<LiveWallpaperEvent, LiveWallpaperState> {
  List<LiveWallpaperModel> _categoryWallpaper = <LiveWallpaperModel>[];
  String searchedString;

  CategoryLiveWallpaperBloc() : super(CategoryLiveWallpaperIsLoading()) {
    on<CategoryLiveWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      LiveWallpaperEvent event, Emitter<LiveWallpaperState> emit) async {
    if (event is CategoryLiveWallpaper) {
      if (event.category != searchedString) {
        searchedString = event.category;
        emit(CategoryLiveWallpaperIsLoading());
        try {
          var response = await http.get(
              Uri.parse(searchLiveWallpaperEndPoint +
                  event.category +
                  "&" +
                  perPageLimit),
              headers: {
                "Accept": "application/json",
                "Authorization": "$apiKey"
              });
          var data = jsonDecode(response.body)["videos"];
          _categoryWallpaper = <LiveWallpaperModel>[];
          for (var i = 0; i < data.length; i++) {
            _categoryWallpaper.add(LiveWallpaperModel.fromMap(data[i]));
          }
          emit(CategoryLiveWallpaperIsLoaded(_categoryWallpaper));
        } on Exception catch (e) {
          emit(CategoryLiveWallpaperIsNotLoaded(e.toString()));
        }
      }
    }
  }
}
