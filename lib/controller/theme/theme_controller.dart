import 'package:get/get.dart';

/// THIS CONTROLLER MANAGE THEME...
class ThemeController extends GetxController {
  bool isDarkMode = false;
  isDarkModeUpdate(bool value, {bool reInit = false}) {
    isDarkMode = value;
    if (!reInit) update();
  }
}
