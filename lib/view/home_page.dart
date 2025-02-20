// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_page_controller.dart';
import '../constants/strings_constants.dart';
import '../constants/sized_box_hw.dart';
import '../constants/color.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() => controller.showImage.value && controller.controller.text.isNotEmpty
                      ? GestureDetector(
                          onDoubleTap: () => controller.showFullScreenImage(context, controller.controller.text),
                          child: Image.network(
                            controller.controller.text,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(child: Text(AppStringConstants.errorMssg)),
                          ),
                        )
                      : const SizedBox.shrink()),
                ),
              ),
            ),
            hb8,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.controller,
                    decoration: const InputDecoration(hintText: AppStringConstants.imageUrl),
                    onChanged: controller.onTextChanged,
                  ),
                ),
                Obx(() => ElevatedButton(
                      onPressed: controller.buttonDisabled.value ? null : controller.onImageButtonPressed,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Icon(Icons.arrow_forward),
                      ),
                    )),
              ],
            ),
            hb100,
          ],
        ),
      ),
      floatingActionButton: Obx(() => controller.showImage.value ? _buildFloatingMenu() : const SizedBox.shrink()),
    );
  }

  /// Builds the floating action menu for fullscreen options.
  Widget _buildFloatingMenu() {
    return Obx(
      () => Stack(
        children: [
          if (controller.isMenuOpen.value)
            GestureDetector(
              onTap: () => controller.isMenuOpen.value = false,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          Positioned(
            bottom: 80,
            right: 16,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: controller.isMenuOpen.value ? 1.0 : 0.0,
              child: Column(
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'tag1',
                    onPressed: () => controller.showFullScreenImage(Get.context!, controller.controller.text),
                    icon: const Icon(Icons.fullscreen),
                    label: const Text(AppStringConstants.enterFullscreen),
                  ),
                  hb8,
                  FloatingActionButton.extended(
                    heroTag: 'tag2',
                    onPressed: controller.exitFullScreen,
                    icon: const Icon(Icons.fullscreen_exit),
                    label: const Text(AppStringConstants.exitFullscreen),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'tag3',
              onPressed: () => controller.isMenuOpen.value = !controller.isMenuOpen.value,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
