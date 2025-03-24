
import 'package:dummy/routes/routes.dart';
import 'package:dummy/routes/screen_bindings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screen/splash_screen/splash.dart';

class AllPages {
  static const String initialRoute = splashScreen;
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: splashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding(),
      ),
    ];
  }
}