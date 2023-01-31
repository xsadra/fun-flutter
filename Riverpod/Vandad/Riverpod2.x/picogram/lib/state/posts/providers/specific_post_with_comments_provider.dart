import 'dart:async' show StreamController;

import 'package:cloud_firestore/cloud_firestore.dart'
    show FieldPath, FirebaseFirestore;
import 'package:hooks_riverpod/hooks_riverpod.dart' show StreamProvider;

import '../../../state/state.dart'
    show
        Comment,
        FirebaseCollectionName,
        FirebaseFieldsName,
        Post,
        PostWithComments,
        RequestForPostAndComment,
        Sorting;

final specificPostWithCommentsProvider = StreamProvider.autoDispose
    .family<PostWithComments, RequestForPostAndComment>(
  (ref, request) {
    final controller = StreamController<PostWithComments>();

    Post? post;
    Iterable<Comment>? comments;

    // Keep watching the post and comments
    void notify() {
      final localPost = post;
      if (localPost == null) {
        return;
      }
      final localComments = (comments ?? []).sortByRequest(request);
      final result = PostWithComments(
        post: localPost,
        comments: localComments,
      );
      controller.sink.add(result);
    }

    final postSubscription = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)
        .where(FieldPath.documentId, isEqualTo: request.postId)
        .limit(1)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          post = null;
          comments = null;
          notify();
          return;
        }
        final doc = snapshot.docs.first;
        if (doc.metadata.hasPendingWrites) {
          return;
        }
        post = Post(
          postId: doc.id,
          data: doc.data(),
        );
        notify();
      },
    );

    final commentsQuery = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FirebaseFieldsName.postId, isEqualTo: request.postId)
        .orderBy(FirebaseFieldsName.createdAt, descending: true);

    final limitedCommentsQuery = request.limit == null
        ? commentsQuery
        : commentsQuery.limit(request.limit!);

    final commentsSubscription = limitedCommentsQuery.snapshots().listen(
      (snapshot) {
        comments = snapshot.docs
            .where((element) => !element.metadata.hasPendingWrites)
            .map(
              (doc) => Comment(id: doc.id, doc.data()),
            )
            .toList();
        notify();
      },
    );

    ref.onDispose(() {
      commentsSubscription.cancel();
      postSubscription.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
