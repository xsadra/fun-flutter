import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart';

final userInfoModelProvider = StreamProvider.autoDispose
    .family<UserInfoModel, UserId>((ref, UserId userId) {
  final controller = StreamController<UserInfoModel>();

  final userInfoModelStream = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.users)
      .where(FirebaseFieldsName.userId, isEqualTo: userId)
      .limit(1)
      .snapshots()
      .listen(
        (event) {
          final doc = event.docs.first;
          final json = doc.data();
          final userInfoModel = UserInfoModel.fromJson(json, userId: userId);
          controller.add(userInfoModel);
        },
      );

  ref.onDispose(() {
    userInfoModelStream.cancel();
    controller.close();
  });

  return controller.stream;
});
