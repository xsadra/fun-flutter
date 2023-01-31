import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;

import '../../../state/state.dart' show PostId, UserId, FirebaseFieldsName;

@immutable
class Like extends MapView<String, String> {
  Like({
    required UserId likedBy,
    required PostId postId,
    required DateTime date,
  }) : super({
          FirebaseFieldsName.userId: likedBy,
          FirebaseFieldsName.postId: postId,
          FirebaseFieldsName.date: date.toIso8601String(),
        });
}
