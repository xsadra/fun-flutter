import 'dart:convert';

import 'package:equatable/equatable.dart';

class DeltaData extends Equatable {
  const DeltaData({
    required this.account,
    required this.delta,
    required this.deviceId,
  });

  final String account;
  final String delta;
  final String deviceId;

  @override
  List<Object?> get props => [account, delta, deviceId];

  DeltaData copyWith({
    String? account,
    String? delta,
    String? deviceId,
  }) {
    return DeltaData(
      account: account ?? this.account,
      delta: delta ?? this.delta,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'account': account,
      'delta': delta,
      'deviceId': deviceId,
    };
  }

  String toJson() => json.encode(toMap());

  factory DeltaData.fromMap(Map<String, dynamic> map) {
    return DeltaData(
      account: map['account'] as String,
      delta: map['delta'] as String,
      deviceId: map['deviceId'] as String,
    );
  }

  @override
  String toString() {
    return 'DeltaData{account: $account, delta: $delta, deviceId: $deviceId}';
  }
}
