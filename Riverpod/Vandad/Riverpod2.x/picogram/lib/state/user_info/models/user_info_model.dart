import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;

import '../../state.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  UserInfoModel({
    required this.userId,
    required this.displayName,
    this.email,
  }) : super({
          FirebaseFieldsName.userId: userId,
          FirebaseFieldsName.displayName: displayName,
          FirebaseFieldsName.email: email,
        });

  final UserId userId;
  final String displayName;
  final String? email;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
    };
  }

  factory UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) {
    return UserInfoModel(
      userId: userId,
      displayName: json[FirebaseFieldsName.displayName] as String ?? '',
      email: json[FirebaseFieldsName.email],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email;

  @override
  int get hashCode => userId.hashCode ^ displayName.hashCode ^ email.hashCode;
}
