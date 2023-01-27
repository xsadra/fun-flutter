import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart' show FieldValue;
import 'package:flutter/foundation.dart' show immutable;

import '../../state.dart' show PostId, UserId, FirebaseFieldsName;

@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required String comment,
    required UserId fromUserId,
    required PostId onPostId,
  }) : super({
          FirebaseFieldsName.comment: comment,
          FirebaseFieldsName.userId: fromUserId,
          FirebaseFieldsName.postId: onPostId,
          FirebaseFieldsName.createdAt: FieldValue.serverTimestamp(),
        });
}
