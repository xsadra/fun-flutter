import 'dart:async' show Completer;

import 'package:flutter/material.dart'
    show Image, ImageConfiguration, ImageInfo, ImageStreamListener, Size;

extension GetImageAspectRatio on Image {
  Future<double> get getAspectRatio async {
    final Completer<double> completer = Completer<double>();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo imageInfo, bool synchronousCall) {
          final Size imageSize = Size(
            imageInfo.image.width.toDouble(),
            imageInfo.image.height.toDouble(),
          );
          imageInfo.image.dispose();
          completer.complete(imageSize.aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}
