import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart'
    show
        Post,
        PostKey,
        userIdProvider,
        FirebaseCollectionName,
        FirebaseFieldsName;

final userPostProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final userId = ref.watch(userIdProvider);

  final controller = StreamController<Iterable<Post>>();

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldsName.createdAt, descending: true)
      .where(PostKey.userId, isEqualTo: userId)
      .snapshots()
      .listen((snapshot) {
    final posts = snapshot.docs
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((doc) => Post(postId: doc.id, data: doc.data()))
        .toList();
    controller.sink.add(posts);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
