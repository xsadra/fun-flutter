import 'package:collection/collection.dart' show IterableEquality;
import 'package:flutter/foundation.dart' show immutable;

import '../../../state/state.dart' show Comment, Post;

@immutable
class PostWithComments {
  const PostWithComments({required this.post, required this.comments});

  final Post post;
  final Iterable<Comment> comments;

  @override
  bool operator ==(covariant PostWithComments other) =>
      post == other.post &&
      const IterableEquality<Comment>().equals(
        comments,
        other.comments,
      );

  @override
  int get hashCode => Object.hashAll([post, comments]);
}
