import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppConstants {
  static const Size designScreenSize = Size(375, 754);
  static const String defaultAppName = "Walla! 4K HD Wallpapers";

  static const String walllpaperTypeEditorChoice = "EditorChoice";
  static const String walllpaperTypeRandom = "Random";

  static const String privacyPolicy =
      "https://doc-hosting.flycricket.io/walla-4k-hd-wallpapers-privacy-policy/9e08e191-b31e-49ff-b519-6187c4f1d502/privacy";

  static const String EULA =
      "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/";

  static String appName;
  static String packageName;
  static String version;
  static String buildNumber;

  Future<void> deleteCache(BuildContext context) async {
    final cacheDir = await getTemporaryDirectory();
    // final appDir = await getApplicationSupportDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
    SnackBar snackBar = SnackBar(
      content: Text('Cache Cleaned!'),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // if (appDir.existsSync()) {
    // appDir.deleteSync(recursive: true);
    // }
  }
}
