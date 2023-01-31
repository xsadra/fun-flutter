import 'dart:async' show StreamController;

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/state.dart'
    show PostId, userIdProvider, FirebaseCollectionName, FirebaseFieldsName;

final hasLikedPostProvider = StreamProvider.autoDispose.family<bool, PostId>(
  (ref, postId) {
    final userId = ref.watch(userIdProvider);

    if (userId == null) {
      return Stream<bool>.value(false);
    }

    final controller = StreamController<bool>();

    final subscription = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldsName.postId, isEqualTo: postId)
        .where(FirebaseFieldsName.userId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        controller.add(snapshot.docs.isNotEmpty);
      },
    );

    ref.onDispose(
      () {
        subscription.cancel();
        controller.close();
      },
    );

    return controller.stream;
  },
);
