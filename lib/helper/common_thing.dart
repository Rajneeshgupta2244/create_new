import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Helper/Colors.dart';
import '../custom_widget/custom_text.dart';
import 'common_text_style.dart';

/// SNACK BAR FOR MSG

void tostMSG(String msg) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.primary,
      content: CommonText(
       text: msg,
        style: CommonTextStyle.customTextStyle(

          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.white,
          height: 2,
         letterSpacing: 2,
         // fontFamily:
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

///CHECK INTERNET CONNECTION

 void checkInternetConnection() {
  final Connectivity connectivity = Connectivity();
  connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
    final hasConnection = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);
    if (hasConnection) {
      tostMSG('CONNECTED');
    } else {
      tostMSG('YOUR CONNECTION HAS BEEN LOSS');
    }
  });
}

