import 'package:flutter/material.dart';

@immutable
class ImageWithAspectRatio{
  const ImageWithAspectRatio({
    required this.image,
    required this.aspectRatio,
  });

  final Image image;
  final double aspectRatio;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageWithAspectRatio &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          aspectRatio == other.aspectRatio;

  @override
  int get hashCode => image.hashCode ^ aspectRatio.hashCode;
}
