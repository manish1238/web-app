// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

import '../constants/strings_constants.dart';
import '../constants/sized_box_hw.dart';
import '../constants/color.dart';
import 'full_screen_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool _buttonDisabled = true;
  bool _showImage = false;
  bool _isMenuOpen = false;

  /// Exits full-screen mode and closes the menu.
  void _exitFullScreen() {
    html.document.exitFullscreen();
    setState(() => _isMenuOpen = false);
  }

  /// Displays the image in full-screen mode.
  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Get.to(() => FullScreenImage(imageUrl: imageUrl));
  }

  /// Updates the button state based on the text field input.
  void _onTextChanged(String value) {
    setState(() {
      _buttonDisabled = value.isEmpty;
      if (!_buttonDisabled) _showImage = false;
    });
  }

  /// Handles the image display when the button is pressed.
  void _onImageButtonPressed() => setState(() => _showImage = true);

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
                  child: _showImage && _controller.text.isNotEmpty
                      ? GestureDetector(
                          onDoubleTap: () => _showFullScreenImage(context, _controller.text),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _controller.text,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(child: Text(AppStringConstants.errorMssg)),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            hb8,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: AppStringConstants.imageUrl),
                    onChanged: _onTextChanged,
                  ),
                ),
                ElevatedButton(
                  onPressed: _buttonDisabled ? null : _onImageButtonPressed,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
            hb100,
          ],
        ),
      ),
      floatingActionButton: _showImage ? _buildFloatingMenu() : const SizedBox.shrink(),
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
            child: Column(
              children: [
                FloatingActionButton.extended(
                  heroTag: 'tag1',
                  onPressed: () => _showFullScreenImage(context, _controller.text),
                  icon: const Icon(Icons.fullscreen),
                  label: const Text(AppStringConstants.enterFullscreen),
                ),
                hb8,
                FloatingActionButton.extended(
                  heroTag: 'tag2',
                  onPressed: _exitFullScreen,
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
            onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
