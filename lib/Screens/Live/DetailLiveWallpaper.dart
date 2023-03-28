import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:walla/Theme/theme_cubit.dart';
import 'package:walla/configs/constants.dart';
import 'dart:io' as io;
import '../../Model/liveWallpaperModel.dart';
import '../../configs/colors.dart';

class DetailLiveWallpaper extends StatefulWidget {
  final VideoFile videoFile;
  DetailLiveWallpaper({@required this.videoFile});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailLiveWallpaper> {
  var padding = EdgeInsets.symmetric(horizontal: 15, vertical: 15);
  bool permission = false;
  bool downloadImage = false;
  String downPer = "0%";
  final String nAvail = "Not Available";
  bool fileExists = false;
  bool isFecthingFile = true;
  VideoPlayerController _controller;
  ChewieController _chewieController;
  Future<void> _future;
  String fileLocation;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  _permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: AppConstants.appName,
    );
    var result = await permissionValidator.storage();
    if (result) {
      setState(() {
        permission = true;
        downloadWallpaper();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfFileAlreadyExist();
  }

  Future<void> checkIfFileAlreadyExist() async {
    final dir = await getApplicationDocumentsDirectory();
    fileLocation =
        "${dir.path}/${AppConstants.appName}/${widget.videoFile.id}.mp4";
    print(fileLocation);
    await io.File(fileLocation).exists();
    fileExists = io.File(fileLocation).existsSync();
    print("fileExists: " + fileExists.toString());
    _controller = fileExists
        ? VideoPlayerController.file(File(fileLocation))
        : VideoPlayerController.network(widget.videoFile.link);
    _controller.setVolume(0.0);
    _future = initVideoPlayer();
    isFecthingFile = false;
  }

  Future<void> initVideoPlayer() async {
    await _controller.initialize();
    setState(() {
      _chewieController = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: _controller.value.aspectRatio,
          autoPlay: true,
          looping: true,
          showOptions: false,
          autoInitialize: true,
          showControls: false,
          placeholder: buildPlaceholderImage());
    });
  }

  buildPlaceholderImage() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Scaffold(
      body: !isFecthingFile
          ? Stack(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return buildPlaceholderImage();

                    return Center(
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                child: Row(mainAxisSize: MainAxisSize.max, children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 15),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withAlpha(50)
                          : Colors.black.withAlpha(50),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDark ? Colors.white : Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: fileExists
                      ? InkWell(
                          onTap: () {
                            shareFile();
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.black : AppColors.black,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.white),
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Icon(
                                        Icons.share,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      : downloadImage
                          ? Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.black.withAlpha(100)
                                    : AppColors.black.withAlpha(100),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "Downloading.. $downPer",
                                  style: TextStyle(
                                      color:
                                          isDark ? Colors.white : Colors.white),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                if (permission == false) {
                                  print("Requesting Permission");
                                  _permissionRequest();
                                } else {
                                  print("Permission Granted.");
                                  downloadWallpaper();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      isDark ? Colors.black : AppColors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Download",
                                        style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : Colors.white),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Icon(
                                          Icons.download,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
            ])
          : buildPlaceholderImage(),
    );
  }

  Future<void> shareFile() async {
    await FlutterShare.shareFile(
        title: 'Live Wallpaper',
        text: 'Here is a cool live wallpaper that i wanted to share with you!',
        filePath: fileLocation);
  }

  void downloadWallpaper() async {
    Dio dio = new Dio();
    dio.download(
      "${widget.videoFile.link}.mp4",
      fileLocation,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          String downloadingPer =
              ((received / total * 100).toStringAsFixed(0) + "%");
          setState(() {
            downPer = downloadingPer;
          });
        }
        setState(() {
          downloadImage = true;
        });
      },
    ).whenComplete(() {
      setState(() {
        downloadImage = false;
        fileExists = true;
      });
      SnackBar snackBar = SnackBar(
          content: Text('Live Wallpaper downloaded to:\n$fileLocation'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
              label: "Open", onPressed: () => {OpenFile.open(fileLocation)}));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // showCupertinoModalBottomSheet(
      //     isDismissible: true,
      //     context: context,
      //     bounce: true,
      //     builder: (_) {
      //       return Container(
      //         margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 50),
      //         child: Row(
      //           mainAxisSize: MainAxisSize.max,
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             GFButton(
      //               shape: GFButtonShape.pills,
      //               color: Colors.orange,
      //               textColor: Colors.white,
      //               onPressed: () {
      //                 initPlatformState(
      //                     "${dir.path}/${AppConstants.appName}.png",
      //                     WallpaperManager.HOME_SCREEN,
      //                     widget.wallpaper.original);
      //                 Navigator.pop(context);
      //               },
      //               text: " Home Screen ",
      //             ),
      //             GFButton(
      //               shape: GFButtonShape.pills,
      //               color: Colors.blue,
      //               textColor: Colors.white,
      //               onPressed: () {
      //                 initPlatformState(
      //                     "${dir.path}/${AppConstants.appName}.png",
      //                     WallpaperManager.LOCK_SCREEN,
      //                     widget.wallpaper.original);
      //                 Navigator.pop(context);
      //               },
      //               text: " Lock Screen ",
      //             ),
      //             GFButton(
      //               shape: GFButtonShape.pills,
      //               color: Colors.green,
      //               textColor: Colors.white,
      //               onPressed: () {
      //                 initPlatformState(
      //                     "${dir.path}/${AppConstants.appName}.png",
      //                     WallpaperManager.BOTH_SCREENS,
      //                     widget.wallpaper.original);
      //                 Navigator.pop(context);
      //               },
      //               text: " Both ",
      //             ),
      //           ],
      //         ),
      //       );
      //     });
    });
  }

  // Future<void> initPlatformState(String path, int location, String url) async {
  //   print("path: " + path);
  //   print("location: " + location.toString());
  //   print("url: " + url);

  //   try {
  //     await WallpaperManager.setWallpaperFromFile(path, location);
  //     Fluttertoast.showToast(
  //         msg: 'Wallpaper Applied.', toastLength: Toast.LENGTH_SHORT);
  //   } on PlatformException {
  //     Fluttertoast.showToast(
  //         msg: 'Failed to get wallpaper. Please Try Again Later.',
  //         toastLength: Toast.LENGTH_SHORT);
  //     print("Platform exception");
  //   }
  //   if (!mounted) return;
  // }
}
