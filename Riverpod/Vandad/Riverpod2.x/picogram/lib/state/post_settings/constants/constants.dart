import 'package:flutter/foundation.dart';

@immutable
class Constants {
  static const String allowLikesTitle = 'Allow likes';
  static const String allowLikesDescription =
      'Allow other users to like your posts';
  static const String allowLikesStorageKey = 'allow_likes';
  static const String allowCommentsTitle = 'Allow comments';
  static const String allowCommentsDescription =
      'Allow other users to comment on your posts';
  static const String allowCommentsStorageKey = 'allow_comments';
  const Constants._();
}
