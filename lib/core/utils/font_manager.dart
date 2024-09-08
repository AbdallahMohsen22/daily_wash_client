import 'package:flutter/material.dart';

class AppFontWeight {
  static const String fontFamily = "Cairo";
}

class FontWeightManager {
  static const FontWeight extraLight = FontWeight.w100;

  static const FontWeight light = FontWeight.w200;

  static const FontWeight regular = FontWeight.w400;

  static const FontWeight medium = FontWeight.w500;

  static const FontWeight semiBold = FontWeight.w600;

  static const FontWeight bold = FontWeight.w700;

  static const FontWeight extraBold = FontWeight.w800;

  static const FontWeight black = FontWeight.w800;
}

class FontManager {
  static TextStyle getExtraLightStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.extraLight, color);
  }

  static TextStyle getLightStyle({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

  static TextStyle getRegularStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  static TextStyle getMediumStyle({
    double fontSize = 14,
    required Color color,
  }) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  static TextStyle getSemiBold({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  static TextStyle getBoldStyle(
      {double fontSize = 14,
      required Color color,
      TextDecoration? textDecoration}) {
    return _getTextStyle(
        fontSize, FontWeightManager.bold, color, textDecoration);
  }

  static TextStyle getExtraBoldStyle(
      {double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.extraBold, color);
  }

  static TextStyle geBlackStyle({double fontSize = 14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.black, color);
  }

  static TextStyle _getTextStyle(
      double fontSize, FontWeight fontWeight, Color color,
      [TextDecoration? textDecoration]) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: AppFontWeight.fontFamily,
        fontWeight: fontWeight,
        decoration: textDecoration,
        color: color);
  }
}
