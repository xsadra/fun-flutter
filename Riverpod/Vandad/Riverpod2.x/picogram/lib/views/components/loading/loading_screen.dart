import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/strings.dart';
import 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final LoadingScreen _instance = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _instance;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    }
    _controller = showOverlay(context: context, text: text);
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required text,
  }) {
    final state = Overlay.of(context);
    if (state == null) {
      return null;
    }

    final textController = StreamController<String>();
    textController.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: size.height / 2,
        left: size.width / 2,
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      StreamBuilder<String>(
                        stream: textController.stream,
                        builder: (context, snapshot) => Text(
                          snapshot.data ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        overlay.remove();
        textController.close();
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}
