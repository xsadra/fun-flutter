import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:uuid/uuid.dart' show Uuid;
import 'package:video_thumbnail/video_thumbnail.dart'
    show ImageFormat, VideoThumbnail;

import '../../state.dart'
    show
        CollectionName,
        CouldNotBuildThumbnailException,
        FileType,
        FirebaseCollectionName,
        GetImageDataAspectRatio,
        ImageConstants,
        IsLoading,
        PostPayload,
        PostSetting,
        UserId,
        isNotLoading;

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(isNotLoading);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }

        final thumbnail = img.copyResize(
          fileAsImage,
          width: ImageConstants.imageThumbnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: ImageConstants.videoThumbnailMaxHeight,
          quality: ImageConstants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }
    final thumbnailAspectRatio = await thumbnailUint8List.getAspectRatio();

    final fileName = const Uuid().v4();

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);

    try {
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final postPayload = PostPayload(
        userId: userId,
        message: message,
        fileType: fileType,
        fileName: fileName,
        fileUrl: await originalFileRef.getDownloadURL(),
        originalFileStorageId: originalFileStorageId,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        thumbnailStorageId: thumbnailStorageId,
        aspectRatio: thumbnailAspectRatio,
        postSetting: postSettings,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
