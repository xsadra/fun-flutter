import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart'
    show
        Comment,
        RequestForPostAndComment,
        FirebaseCollectionName,
        FirebaseFieldsName,
        Sorting;

final postCommentProvider = StreamProvider.autoDispose
    .family<Iterable<Comment>, RequestForPostAndComment>(
  (ref, RequestForPostAndComment request) {
    final controller = StreamController<Iterable<Comment>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FirebaseFieldsName.postId, isEqualTo: request.postId)
        .snapshots()
        .listen((snapshot) {
      final documents = snapshot.docs;
      final limitedDocuments =
          request.limit != null ? documents.take(request.limit!) : documents;
      final comments = limitedDocuments
          .where((element) => !element.metadata.hasPendingWrites)
          .map((doc) => Comment(id: doc.id, doc.data()))
          .toList();

      final sortedComments = comments.sortByRequest(request);
      controller.add(sortedComments);
    });

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);
