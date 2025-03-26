import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  void toggleTheme() {
    if (currentTheme.value == ThemeMode.light) {
      currentTheme.value = ThemeMode.dark;
    } else {
      currentTheme.value = ThemeMode.light;
    }
  }
  void updateSystemTheme() {
    currentTheme.value = WidgetsBinding.instance.window.platformBrightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
