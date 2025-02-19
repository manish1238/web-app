// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

import 'home_page.dart';
import '../constants/color.dart';
import '../constants/strings_constants.dart';

/// Full-Screen Image Widget
class FullScreenImage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _isMenuOpen = false;

  /// exit full screen mode
  void _goPreviousScreen(BuildContext context) {
    Navigator.pop(context);
    Get.to(() => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text("Invalid Image URL"));
          },
        ),
      ),
      floatingActionButton: _buildFloatingMenu(),
    );
  }

  /// Builds the floating action menu for fullscreen options.
  Widget _buildFloatingMenu() {
    return Stack(
      children: [
        if (_isMenuOpen)
          GestureDetector(
            onTap: () => setState(() => _isMenuOpen = false),
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
            opacity: _isMenuOpen ? 1.0 : 0.0,
            child: FloatingActionButton.extended(
              onPressed: () => _goPreviousScreen(context),
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
            child: const Icon(Icons.add),
            onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
          ),
        ),
      ],
    );
  }
}
