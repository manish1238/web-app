import 'dart:developer';

import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../../constants/strings_constants.dart';
import '../../constants/color.dart';
import 'full_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  bool buttonDisabled = true;
  bool showImage = false;
  bool isMenuOpen = false;

  void enterFullScreen() {
    html.document.documentElement?.requestFullscreen();
    setState(() {
      isMenuOpen = false; // Close menu
    });
  }

  void exitFullScreen() {
    html.document.exitFullscreen();
    setState(() {
      isMenuOpen = false; // Close menu
    });
  }

  /// Function to show image in full screen
  void showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
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
                  child: !showImage
                      ? Container(height: 100, width: 100, color: red)
                      : controller.text.isEmpty
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onDoubleTap: () {
                                if (controller.text.isNotEmpty) {
                                  showFullScreenImage(context, controller.text);
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  controller.text,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(child: Text(AppStringConstants.appName));
                                  },
                                ),
                              ),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: AppStringConstants.imageUrl),
                    onChanged: (value) {
                      setState(() {
                        buttonDisabled = value.isEmpty;
                        if (!buttonDisabled) {
                          showImage = false;
                        }
                        log('---$buttonDisabled');
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: buttonDisabled
                      ? null
                      : () {
                          setState(() {
                            showImage = true;
                            log('ElevatedButton---$buttonDisabled');
                          });
                        },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
      floatingActionButton: showImage
          ? Stack(
              children: [
                if (isMenuOpen)
                  GestureDetector(
                    onTap: () => setState(() => isMenuOpen = false),
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
                    opacity: isMenuOpen ? 1.0 : 0.0,
                    child: Column(
                      children: [
                        FloatingActionButton.extended(
                          onPressed: enterFullScreen,
                          icon: const Icon(Icons.fullscreen),
                          label: const Text(AppStringConstants.enterFullscreen),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.extended(
                          onPressed: exitFullScreen,
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
                    onPressed: () => setState(() => isMenuOpen = !isMenuOpen),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
