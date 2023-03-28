import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/Theme/theme_cubit.dart';
import 'package:walla/configs/colors.dart';

import '../../Bloc/LiveWallpaper/liveWallpaperEvent.dart';
import '../../Bloc/LiveWallpaper/liveWallpaperState.dart';
import '../../Bloc/LiveWallpaper/searchLiveWallpaperBlock.dart';
import '../../Component/wallpaperGridView.dart';

class SearchLive extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

extension ParseToString on SingingCharacter {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

enum SingingCharacter { portrait, landscape, all }

class _SearchState extends State<SearchLive> {
  int counter = 0;
  SearchLiveWallpaperBloc _wallpaperBloc;
  final TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Icon actionIcon = Icon(Icons.search);
  SingingCharacter _character = SingingCharacter.portrait;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    _wallpaperBloc = BlocProvider.of<SearchLiveWallpaperBloc>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _data(context, isDark),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 115),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isDark
                            ? Colors.black.withAlpha(50)
                            : AppColors.black.withAlpha(50)),
                    color: isDark
                        ? AppColors.black.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 10,
                        blurRadius: 50,
                        color: Colors.black.withOpacity(.1),
                        offset: Offset(20, 20),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  focusNode: _focusNode,
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        left: 10.0,
                                        bottom: 10.0,
                                        top: 10.0,
                                        right: 0),
                                    hintText: "Search..",
                                  ),
                                  keyboardType: TextInputType.text,
                                  onEditingComplete: () {
                                    onSearch(context);
                                  },
                                ),
                              ),
                              IconButton(
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  onSearch(context);
                                },
                                icon: Icon(Icons.search,
                                    color:
                                        isDark ? Colors.white : Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              flex: 250,
                              fit: FlexFit.tight,
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Radio<SingingCharacter>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      value: SingingCharacter.portrait,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter value) {
                                        setState(() {
                                          _character = value;
                                        });
                                        onSearch(context);
                                      },
                                    ),
                                    Text(" Portrait",
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 300,
                              fit: FlexFit.tight,
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Radio<SingingCharacter>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      value: SingingCharacter.landscape,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter value) {
                                        setState(() {
                                          _character = value;
                                        });
                                        onSearch(context);
                                      },
                                    ),
                                    Text(
                                      " Landscape",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 200,
                              fit: FlexFit.tight,
                              child: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Radio<SingingCharacter>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity,
                                      ),
                                      value: SingingCharacter.all,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter value) {
                                        setState(() {
                                          _character = value;
                                        });
                                        onSearch(context);
                                      },
                                    ),
                                    Text(" All",
                                        style: TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSearch(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (searchController.text.isNotEmpty) {
      _wallpaperBloc.add(SearchLiveWallpaper(
          string: searchController.text,
          orientation: _character.toShortString()));
    }
  }

  Widget _data(BuildContext context, bool isDark) {
    return BlocBuilder<SearchLiveWallpaperBloc, LiveWallpaperState>(
      builder: (BuildContext context, LiveWallpaperState state) {
        if (state is SearchLiveWallpaperNotSearched) {
          return Center(
            child: Text("Search Wallpaper"),
          );
        } else if (state is SearchLiveWallpaperIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchLiveWallpaperIsLoaded) {
          return WallpaperGridView(
              state: state,
              isDark: isDark,
              onPressed: () {
                setState(() {});
              });
        } else if (state is SearchLiveWallpaperIsNotLoaded) {
          return Center(
            child: Text("Error Loading Live Wallpapers."),
          );
        } else {
          return Center(
            child: Text("Search Live Wallpaper"),
          );
        }
      },
    );
  }
}
