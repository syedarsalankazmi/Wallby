import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/const.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import '../../Model/liveWallpaperModel.dart';
import 'liveWallpaperEvent.dart';
import 'liveWallpaperState.dart';

class SearchLiveWallpaperBloc
    extends Bloc<LiveWallpaperEvent, LiveWallpaperState> {
  List<LiveWallpaperModel> _searchWallpaper = <LiveWallpaperModel>[];
  String searchedString;
  String searchedOrientation;

  SearchLiveWallpaperBloc() : super(SearchLiveWallpaperNotSearched()) {
    on<SearchLiveWallpaper>(
      mapEventToState,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  void mapEventToState(
      LiveWallpaperEvent event, Emitter<LiveWallpaperState> emit) async {
    if (event is SearchLiveWallpaper) {
      if (event.string != searchedString ||
          event.orientation != searchedOrientation) {
        searchedString = event.string;
        searchedOrientation = event.orientation;
        emit(SearchLiveWallpaperIsLoading());
        try {
          String orientation = "";
          if (event.orientation != "All") {
            orientation = "&orientation=${event.orientation}";
          }
          String url = searchLiveWallpaperEndPoint +
              event.string +
              "&" +
              perPageLimit +
              orientation;
          var response = await http.get(Uri.parse(url), headers: {
            "Accept": "application/json",
            "Authorization": "$apiKey"
          });
          var data = jsonDecode(response.body)["videos"];
          _searchWallpaper = <LiveWallpaperModel>[];
          for (var i = 0; i < data.length; i++) {
            _searchWallpaper.add(LiveWallpaperModel.fromMap(data[i]));
          }
          emit(SearchLiveWallpaperIsLoaded(_searchWallpaper));
        } on Exception catch (e) {
          emit(SearchLiveWallpaperIsNotLoaded(e.toString()));
        }
      }
    }
  }
}
