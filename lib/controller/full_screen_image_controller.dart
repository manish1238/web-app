
import 'package:get/get.dart';

/// Controller for managing full-screen image state
class FullScreenImageController extends GetxController {
  var isMenuOpen = false.obs;

  /// Toggles the floating menu visibility
  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;

  /// Exits full screen mode
  void goPreviousScreen() => Get.back();
}