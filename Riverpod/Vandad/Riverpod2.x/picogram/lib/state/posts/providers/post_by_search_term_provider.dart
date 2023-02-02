import 'dart:async' show StreamController;
import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart'
    show FirebaseCollectionName, FirebaseFieldsName, Post, SearchTerm;

final postBySearchTermProvider = StreamProvider.autoDispose
    .family<Iterable<Post>, SearchTerm>((ref, searchTerm) {
  final controller = StreamController<Iterable<Post>>();

  final subscription = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldsName.createdAt, descending: true)
      .snapshots()
      .listen((snapshot) {
    final posts = snapshot.docs
        .map(
          (doc) => Post(
            postId: doc.id,
            data: doc.data(),
          ),
        )
        .where(
          (post) =>
              post.message.toLowerCase().contains(searchTerm.toLowerCase()),
        );
    controller.sink.add(posts);
  }, onError: (error) {
    log(error.toString(), name: 'postBySearchTermProvider');
  });

  ref.onDispose(
    () {
      subscription.cancel();
      controller.close();
    },
  );
  return controller.stream;
});
