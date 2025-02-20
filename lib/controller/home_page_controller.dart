
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/full_screen_image.dart';

/// Controller for managing state using GetX.
class HomeController extends GetxController {
  final TextEditingController controller = TextEditingController();
  var buttonDisabled = true.obs;
  var showImage = false.obs;
  var isMenuOpen = false.obs;

  /// Updates the button state based on the text field input.
  void onTextChanged(String value) {
    buttonDisabled.value = value.isEmpty;
    if (!buttonDisabled.value) {
      showImage.value = false;
    }
  }

  /// Handles the image display when the button is pressed.
  void onImageButtonPressed() => showImage.value = true;

  /// Exits full-screen mode and closes the menu.
  void exitFullScreen() => isMenuOpen.value = false;

  /// Displays the image in full-screen mode.
  void showFullScreenImage(BuildContext context, String imageUrl) => Get.to(() => FullScreenImage(imageUrl: imageUrl));
}
