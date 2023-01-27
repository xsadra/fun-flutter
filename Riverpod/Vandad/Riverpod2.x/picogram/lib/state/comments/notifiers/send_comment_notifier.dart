import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);

  set isLoading(bool isLoading) => state = isLoading;

  Future<bool> sendComment({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) async {
    isLoading = true;

    final payload = CommentPayload(
      comment: comment,
      fromUserId: fromUserId,
      onPostId: onPostId,
    );

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
