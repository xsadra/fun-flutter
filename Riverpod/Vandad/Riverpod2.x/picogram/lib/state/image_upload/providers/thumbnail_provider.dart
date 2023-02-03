import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../image_upload.dart';

part 'thumbnail_provider.g.dart';

@riverpod
Future<ImageWithAspectRatio> thumbnail(ThumbnailRef ref,
    {required ThumbnailRequest request}) async {
  final Image image;

  switch (request.fileType) {
    case FileType.image:
      image = Image.file(request.file, fit: BoxFit.fitHeight);
      break;
    case FileType.video:
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumbnail == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(thumbnail, fit: BoxFit.fitHeight);
      break;
  }

  final aspectRatio = await image.getAspectRatio;

  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
}
