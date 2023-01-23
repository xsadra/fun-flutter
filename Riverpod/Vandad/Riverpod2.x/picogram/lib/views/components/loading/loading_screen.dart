import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/components_strings.dart';
import 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  static final LoadingScreen _instance = LoadingScreen._sharedInstance();

  factory LoadingScreen.instance() => _instance;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = ComponentStrings.loading,
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
      builder: (context) => Material(
        color: Colors.black.withOpacity(0.5),
        child: Center(
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    StreamBuilder<String>(
                      stream: textController.stream,
                      builder: (context, snapshot) => Text(
                        snapshot.data ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
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
