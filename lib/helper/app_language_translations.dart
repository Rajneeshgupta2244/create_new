import 'package:get/get.dart';
import 'app_language_files/en_US.dart';
import 'app_language_files/hi_IN.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS.messages,
    'hi_IN': hiIN.messages,
  };
}
