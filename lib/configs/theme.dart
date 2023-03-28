import 'package:flutter/material.dart';
import 'package:walla/configs/colors.dart';

import 'fonts.dart';

class Themings {
  static final TextStyle darkText = TextStyle(
    color: Colors.white,
    fontFamily: AppFonts.circularStd,
  );

  static final TextStyle lightText = TextStyle(
    color: Colors.black,
    fontFamily: AppFonts.circularStd,
  );

  static final ThemeData darkTheme = ThemeData(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      brightness: Brightness.dark,
      // accentColor: Colors.white,
      primaryColor: Colors.black,
      dialogBackgroundColor: Colors.black,
      cardColor: Colors.black,
      primarySwatch: Colors.orange,
      backgroundColor: Colors.black,
      // brightness: Brightness.dark,
      // primaryColor: AppColors.blue,
      snackBarTheme: const SnackBarThemeData(
        actionTextColor: Colors.orange,
        backgroundColor: Colors.black,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        toolbarTextStyle: darkText,
      ),
      textTheme: TextTheme(
        bodyText1: darkText,
        bodyText2: darkText,
        labelMedium: darkText,
        caption: darkText,
        button: darkText,
        overline: darkText,
      ),
      scaffoldBackgroundColor: Colors.black,
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
      ));

  static final ThemeData lightTheme = ThemeData(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      brightness: Brightness.light,
      cardColor: Colors.white,
      // accentColor: Colors.black,
      dialogBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      primarySwatch: Colors.orange,
      backgroundColor: Colors.white,
      // brightness: Brightness.light,
      // primaryColor: AppColors.blue,
      snackBarTheme: const SnackBarThemeData(
        actionTextColor: Colors.orange,
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(color: Colors.black),
      ),
      appBarTheme: AppBarTheme(
        toolbarTextStyle: lightText,
      ),
      textTheme: TextTheme(
        bodyText1: lightText,
        bodyText2: lightText,
        labelMedium: lightText,
        caption: lightText,
        button: lightText,
        overline: lightText,
      ),
      scaffoldBackgroundColor: Colors.white,
      radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
      ));
}
