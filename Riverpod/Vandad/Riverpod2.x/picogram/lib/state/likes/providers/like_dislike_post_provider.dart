import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:picogram/state/state.dart';

final likeDislikePostProvider = FutureProvider.autoDispose
    .family<bool, LikeDislikeRequest>((ref, request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldsName.postId, isEqualTo: request.postId)
      .where(FirebaseFieldsName.userId, isEqualTo: request.userId)
      .get();

  final hasLiked = (await query).docs.isNotEmpty;

  if (hasLiked) {
    try {
      await query.then((value) => value.docs.first.reference.delete());
      return true;
    } catch (e) {
      return false;
    }
  }
  final like = Like(
    likedBy: request.userId,
    postId: request.postId,
    date: DateTime.now(),
  );

  try {
    await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .add(like);
    return true;
  } catch (e) {
    return false;
  }
});
