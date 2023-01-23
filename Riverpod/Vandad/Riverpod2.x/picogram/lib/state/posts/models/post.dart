import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../image_upload/image_upload.dart';
import '../../post_settings/post_settings.dart';
import '../posts.dart';

@immutable
class Post {
  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId] as String,
        message = json[PostKey.message] as String,
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl] as String,
        fileUrl = json[PostKey.fileUrl] as String,
        fileType = FileType.values.firstWhere(
          (e) => e.name == json[PostKey.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[PostKey.fileName] as String,
        aspectRatio = json[PostKey.aspectRatio] as double,
        postSettings = {
          for (final e in json[PostKey.postSettings].entries)
            PostSetting.values.firstWhere(
              (e2) => e2.storageKey == e.key,
            ): e.value as bool,
        },
        thumbnailStorageId = json[PostKey.thumbnailStorageId] as String,
        originalFileStorageId = json[PostKey.originalFileStorageId] as String;

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
