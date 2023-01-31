import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart'
    show
        CollectionName,
        FirebaseCollectionName,
        FirebaseFieldsName,
        IsLoading,
        Post,
        PostId;

typedef Succeeded = bool;

class DeletePostStateNotifier extends StateNotifier<IsLoading> {
  DeletePostStateNotifier() : super(false);

  set isLoading(bool isLoading) => state = isLoading;

  Future<Succeeded> deletePost({
    required Post post,
  }) async {
    isLoading = true;
    try {
      await FirebaseStorage.instance
          .ref()
          .child(post.postId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.thumbnailStorageId)
          .delete()
          .catchError(
              (e) => log(e.toString(), name: 'DeletePostStateNotifier'));

      await FirebaseStorage.instance
          .ref()
          .child(post.postId)
          .child(post.fileType.collectionName)
          .child(post.originalFileStorageId)
          .delete()
          .catchError(
              (e) => log(e.toString(), name: 'DeletePostStateNotifier'));

      await _deleteDocuments(
        postId: post.postId,
        collectionPath: FirebaseCollectionName.comments,
      );

      await _deleteDocuments(
        postId: post.postId,
        collectionPath: FirebaseCollectionName.likes,
      );

      final postRef = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(FirebaseFieldsName.postId, isEqualTo: post.postId)
          .limit(1)
          .get();
      for (var doc in postRef.docs) {
        doc.reference.delete();
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteDocuments({
    required PostId postId,
    required String collectionPath,
  }) async {
    FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(seconds: 20),
      (transaction) async {
        final postRef = await FirebaseFirestore.instance
            .collection(collectionPath)
            .where(FirebaseFieldsName.postId, isEqualTo: postId)
            .get();
        for (var doc in postRef.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }
}
