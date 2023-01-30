import 'package:flutter/foundation.dart' show immutable;

import '../../../lib.dart';

@immutable
class RequestForPostAndComment {
  const RequestForPostAndComment({
    required this.postId,
    this.sortByCreatedAt = true,
    this.sortOrder = SortOrder.newOnTop,
    this.limit,
  });

  final PostId postId;
  final bool sortByCreatedAt;
  final SortOrder sortOrder;
  final int? limit;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestForPostAndComment &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          sortByCreatedAt == other.sortByCreatedAt &&
          sortOrder == other.sortOrder &&
          limit == other.limit;

  @override
  int get hashCode =>
      postId.hashCode ^
      sortByCreatedAt.hashCode ^
      sortOrder.hashCode ^
      limit.hashCode;
}
