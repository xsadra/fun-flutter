import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart'
    show FirebaseCollectionName, FirebaseFieldsName, PostId;

final postLikeCountProvider = StreamProvider.family.autoDispose<int, PostId>(
  (ref, postId) {
    final controller = StreamController<int>();

    controller.onListen = () {
      controller.sink.add(0);
    };

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldsName.postId, isEqualTo: postId)
        .snapshots()
        .listen((snapshot) {
      controller.sink.add(snapshot.docs.length);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
