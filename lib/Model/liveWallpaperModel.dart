// To parse this JSON data, do
//
//     final liveWallpaper = liveWallpaperFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LiveWallpaperModel liveWallpaperFromJson(String str) =>
    LiveWallpaperModel.fromMap(json.decode(str));

String liveWallpaperToJson(LiveWallpaperModel data) =>
    json.encode(data.toJson());

class LiveWallpaperModel {
  LiveWallpaperModel({
    @required this.id,
    @required this.width,
    @required this.height,
    @required this.url,
    @required this.image,
    @required this.fullRes,
    @required this.tags,
    @required this.duration,
    @required this.user,
    @required this.videoFiles,
    @required this.videoPictures,
  });

  int id;
  int width;
  int height;
  String url;
  String image;
  dynamic fullRes;
  List<dynamic> tags;
  int duration;
  User user;
  List<VideoFile> videoFiles;
  List<VideoPicture> videoPictures;

  factory LiveWallpaperModel.fromMap(Map<String, dynamic> json) =>
      LiveWallpaperModel(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        image: json["image"],
        fullRes: json["full_res"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        duration: json["duration"],
        user: User.fromJson(json["user"]),
        videoFiles: List<VideoFile>.from(
            json["video_files"].map((x) => VideoFile.fromJson(x))),
        videoPictures: List<VideoPicture>.from(
            json["video_pictures"].map((x) => VideoPicture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "image": image,
        "full_res": fullRes,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "duration": duration,
        "user": user.toJson(),
        "video_files": List<dynamic>.from(videoFiles.map((x) => x.toJson())),
        "video_pictures":
            List<dynamic>.from(videoPictures.map((x) => x.toJson())),
      };
}

class User {
  User({
    @required this.id,
    @required this.name,
    @required this.url,
  });

  int id;
  String name;
  String url;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class VideoFile {
  VideoFile({
    @required this.id,
    @required this.quality,
    @required this.fileType,
    @required this.width,
    @required this.height,
    @required this.fps,
    @required this.link,
  });

  int id;
  String quality;
  String fileType;
  int width;
  int height;
  double fps;
  String link;

  factory VideoFile.fromJson(Map<String, dynamic> json) => VideoFile(
        id: json["id"],
        quality: json["quality"],
        fileType: json["file_type"],
        width: json["width"],
        height: json["height"],
        fps: json["fps"]?.toDouble(),
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quality": quality,
        "file_type": fileType,
        "width": width,
        "height": height,
        "fps": fps,
        "link": link,
      };
}

class VideoPicture {
  VideoPicture({
    @required this.id,
    @required this.picture,
    @required this.nr,
  });

  int id;
  String picture;
  int nr;

  factory VideoPicture.fromJson(Map<String, dynamic> json) => VideoPicture(
        id: json["id"],
        picture: json["picture"],
        nr: json["nr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "nr": nr,
      };
}
