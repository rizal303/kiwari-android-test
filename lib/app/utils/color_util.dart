import 'package:flutter/material.dart';

class ColorUtil {
  static final ColorUtil _singleton = ColorUtil._internal();

  factory ColorUtil() => _singleton;

  ColorUtil._internal();

  Color parseHexColor(String hexColorString) {
    if (hexColorString == null) {
      return null;
    }
    hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    int colorInt = int.parse(hexColorString, radix: 16);
    return Color(colorInt);
  }
}
