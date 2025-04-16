import 'package:flutter/material.dart';

class CommonTextStyle {
  /// Font Families
  static const fontFirst = "Gilroy";
  static const gilroyMedium = "Gilroy-Medium";
  static const gilroyRegular = "Gilroy-Regular";
  static const gilroyBold = "Gilroy-Bold";
  static const gilroySemiBold = "Gilroy-SemiBold";

  /// Custom TextStyle
  static TextStyle customTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    bool underline = false,
  }) {
    return TextStyle(
      fontFamily: fontFirst,
      fontSize: fontSize ?? null,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? null,
      letterSpacing: letterSpacing ?? 0.0,
      height: height ?? null,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
