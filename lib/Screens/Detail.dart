import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:walla/Model/staticWallpaperModel.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:walla/Theme/theme_cubit.dart';
import 'package:walla/configs/constants.dart';
import 'dart:io' as io;

import '../configs/colors.dart';

class Detail extends StatefulWidget {
  final Wallpaper wallpaper;
  final bool isPortrait;
  Detail({@required this.wallpaper, @required this.isPortrait});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var padding = EdgeInsets.symmetric(horizontal: 15, vertical: 15);
  bool permission = false;
  bool downloadImage = false;
  bool fileExists = false;
  String downPer = "0%";
  final String nAvail = "Not Available";
  String fileLocation;
  bool isFecthingFile = true;

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
        "${dir.path}/${AppConstants.appName}/${widget.wallpaper.id}.png";
    print(fileLocation);
    await io.File(fileLocation).exists();
    isFecthingFile = false;
    setState(() {
      fileExists = io.File(fileLocation).existsSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Scaffold(
      body: !isFecthingFile
          ? Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: PinchZoom(
                    resetDuration: const Duration(milliseconds: 100),
                    maxScale: 3,
                    child: !fileExists
                        ? CachedNetworkImage(
                            imageUrl: widget.isPortrait
                                ? widget.wallpaper.src.portrait
                                : widget.wallpaper.src.landscape,
                            fit: widget.isPortrait
                                ? BoxFit.cover
                                : BoxFit.fitWidth,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Image(
                            image: FileImage(File(fileLocation)),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              debugPrint('image loading...');
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            fit: widget.isPortrait
                                ? BoxFit.cover
                                : BoxFit.fitWidth,
                          ),
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
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                        color: isDark
                                            ? Colors.white
                                            : Colors.white),
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
              ],
            )
          : buildPlaceholderImage(),
    );
  }

  buildPlaceholderImage() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> shareFile() async {
    await FlutterShare.shareFile(
        title: 'Wallpaper',
        text: 'Here is a cool wallpaper that i wanted to share with you!',
        filePath: fileLocation);
  }

  void downloadWallpaper() async {
    Dio dio = new Dio();
    dio.download(
      widget.wallpaper.src.original,
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
          content: Text('Wallpaper downloaded to:\n$fileLocation'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
              label: "Open", onPressed: () => {OpenFile.open(fileLocation)}));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
