import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/foundation.dart' show immutable;

import '../../state.dart' show CommentId, PostId, UserId, FirebaseFieldsName;

@immutable
class Comment {
  final CommentId id;
  final String comment;
  final DateTime createdAt;
  final UserId fromUserId;
  final PostId onPostId;

  Comment(Map<String, dynamic> json, {required this.id})
      : comment = json[FirebaseFieldsName.comment],
        createdAt = (json[FirebaseFieldsName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldsName.userId],
        onPostId = json[FirebaseFieldsName.postId];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;

  @override
  int get hashCode =>
      id.hashCode ^
      comment.hashCode ^
      createdAt.hashCode ^
      fromUserId.hashCode ^
      onPostId.hashCode;
}
