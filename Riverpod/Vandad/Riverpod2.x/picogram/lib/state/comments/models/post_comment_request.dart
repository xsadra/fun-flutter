import 'package:flutter/foundation.dart' show immutable;

import '../../../lib.dart';

@immutable
class RequestForPostAndComment {
  const RequestForPostAndComment({
    required this.postId,
    required this.sortByCreatedAt,
    required this.dateSorting,
    this.limit,
  });

  final PostId postId;
  final bool sortByCreatedAt;
  final DateSorting dateSorting;
  final int? limit;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestForPostAndComment &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          sortByCreatedAt == other.sortByCreatedAt &&
          dateSorting == other.dateSorting &&
          limit == other.limit;

  @override
  int get hashCode =>
      postId.hashCode ^
      sortByCreatedAt.hashCode ^
      dateSorting.hashCode ^
      limit.hashCode;
}
