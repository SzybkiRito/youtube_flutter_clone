import 'package:flutter/material.dart';
import 'package:youtube_clone/classess/Colors.dart';

ThemeData youtubeThemeData = ThemeData(
  scaffoldBackgroundColor: YoutubeColors().defaultBackgroundColor,
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
    ),
  ),
);
