import 'package:flutter/foundation.dart' show immutable;

import '../../posts/posts.dart' show PostId, UserId;

@immutable
class LikeDislikeRequest{

  const LikeDislikeRequest({
    required this.postId,
    required this.userId,
  });

  final PostId postId;
  final UserId userId;
}