import 'package:dummy/Helper/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import for localization delegates
import 'helper/app_focus_manager.dart';
import 'helper/app_language_translations.dart';
import 'helper/app_theme/app_theme.dart';
import 'helper/constants.dart';
import 'routes/all_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(GlobalFocusManager(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return ScreenUtilInit(
      designSize: const Size(393, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            getPages: AllPages.getPages(),
            initialRoute: AllPages.initialRoute,
            themeMode: themeController.currentTheme.value,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.white,
                primary: AppColors.primary,
              ),
              primaryColor: AppColors.primary,
              appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
            ),
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.blueGrey,
              appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey),
              colorScheme: ColorScheme.dark(primary: Colors.blueGrey),
            ),
            translations: AppTranslations(),
            locale: Locale('en', 'US'),
            fallbackLocale: Locale('en', 'US'),
            supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN')],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
        });
      },
    );
  }
}
