// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color.dart';
import '../constants/strings_constants.dart';
import '../controller/full_screen_image_controller.dart';

/// Full-Screen Image Widget
class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final FullScreenImageController controller = Get.put(FullScreenImageController());

    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text(AppStringConstants.invalidImageUrl));
          },
        ),
      ),
      floatingActionButton: _buildFloatingMenu(controller),
    );
  }

  /// Builds the floating action menu for fullscreen options.
  Widget _buildFloatingMenu(FullScreenImageController controller) {
    return Obx(
      () => Stack(
        children: [
          if (controller.isMenuOpen.value)
            GestureDetector(
              onTap: controller.toggleMenu,
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
              child: FloatingActionButton.extended(
                onPressed: controller.goPreviousScreen,
                icon: const Icon(Icons.fullscreen_exit),
                label: const Text(AppStringConstants.exitFullscreen),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'tag1',
              onPressed: controller.toggleMenu,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
