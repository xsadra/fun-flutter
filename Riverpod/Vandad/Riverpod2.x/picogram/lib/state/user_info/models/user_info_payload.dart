import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_fields_name.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required String userId,
    required String? displayName,
    required String? email,
  }) : super({
          FirebaseFieldsName.userId: userId,
          FirebaseFieldsName.displayName: displayName ?? '',
          FirebaseFieldsName.email: email ?? '',
        });
}
