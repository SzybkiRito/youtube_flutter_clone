import 'package:flutter/material.dart';

class YoutubeColors {
  Color get defaultBackgroundColor => HexColor('#212121');
  Color get defaultButtonColor => HexColor('#383838');
  Color get shimmerBackgroundColor => HexColor('#3a3a3a');
  Color get shimmerHighlightColor => HexColor('#3f3f3f');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
