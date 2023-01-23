import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../image_upload/image_upload.dart';
import '../../post_settings/post_settings.dart';
import '../posts.dart';

@immutable
class Post {
  Post({
    required this.postId,
    required Map<String, dynamic> data,
  })  : userId = data[PostKey.userId] as String,
        message = data[PostKey.message] as String,
        createdAt = (data[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = data[PostKey.thumbnailUrl] as String,
        fileUrl = data[PostKey.fileUrl] as String,
        fileType = FileType.values.firstWhere(
          (e) => e.name == data[PostKey.fileType],
          orElse: () => FileType.image,
        ),
        fileName = data[PostKey.fileName] as String,
        aspectRatio = data[PostKey.aspectRatio] as double,
        postSettings = {
          for (final e in data[PostKey.postSettings].entries)
            PostSetting.values.firstWhere(
              (e2) => e2.storageKey == e.key,
            ): e.value as bool,
        },
        thumbnailStorageId = data[PostKey.thumbnailStorageId] as String,
        originalFileStorageId = data[PostKey.originalFileStorageId] as String;

  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final Map<PostSetting, bool> postSettings;
  final String thumbnailStorageId;
  final String originalFileStorageId;

  bool get allowLikes => postSettings[PostSetting.allowLikes] ?? false;

  bool get allowComments => postSettings[PostSetting.allowComments] ?? false;
}
