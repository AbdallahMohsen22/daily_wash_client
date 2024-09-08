import 'package:flutter/material.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: AppFontWeight.fontFamily,
    primaryColor: ColorResources.primaryColor,
    canvasColor: ColorResources.primaryColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: ColorResources.white,
      centerTitle: true,
    ),
  );
}
