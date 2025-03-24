
import 'package:get/get.dart';
import '../screen/splash_screen/splash_controller.dart';
class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
