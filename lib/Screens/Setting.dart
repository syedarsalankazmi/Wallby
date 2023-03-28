import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walla/configs/constants.dart';

import '../Theme/theme_cubit.dart';
import '../configs/colors.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.black : Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.orange.shade800,
        title: Text("Settings", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.numbers,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "App Version",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${AppConstants.version ?? "1.0.0"} "),
          ),
          ListTile(
            leading: Icon(
              Icons.feedback,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "Share your feedback",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Your feedback is valuable to us. Tell us what you think."),
            onTap: () => _shareFeedback(),
          ),
          ListTile(
            leading: Icon(
              Icons.cleaning_services_rounded,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "Cache Cleaner",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Keep Your mobile device running smoothly!"),
            onTap: () => {
              new Timer(const Duration(milliseconds: 2000), () {
                AppConstants().deleteCache(context);
              })
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people_alt,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "About Us",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'We are a team of innovative developers and designers dedicated to creating cutting-edge technology that combines the power of artificial intelligence with the creativity of human expression.\n\nOur app, \'${AppConstants.appName ?? AppConstants.defaultAppName}\' is the result of our passion for using technology to simplify everyday tasks and bring joy and inspiration to people\'s lives.'),
          ),
          ListTile(
            leading: Icon(
              Icons.shield,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "Privacy Policy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _launchUrl(AppConstants.privacyPolicy),
          ),
          ListTile(
            leading: Icon(
              Icons.handshake,
              color: isDark ? Colors.white : Colors.black,
            ),
            title: Text(
              "End-User-License-Agreement(EULA)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => _launchUrl(AppConstants.EULA),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  _shareFeedback() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}
