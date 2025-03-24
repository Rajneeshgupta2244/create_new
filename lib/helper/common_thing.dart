import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helper/Colors.dart';
import 'constants.dart';

/// Custom Text Style
TextStyle customTextStyle({
  String? fontFamily,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? letterSpacing,
  double? height,
  bool underline = false,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
    decoration: underline ? TextDecoration.underline : TextDecoration.none,
  );
}

/// Snack bar

void snackBar(String msg) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primary,
      content: Text(
        msg,
        style: customTextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          fontFamily: AppConstants.gilroySemiBold,
          color: AppColors.primary,
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
