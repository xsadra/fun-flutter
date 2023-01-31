import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart' show Post, userIdProvider;

final canCurrentUserDeletePostProvider =
    StreamProvider.autoDispose.family<bool, Post>(
  (ref, post) async* {
    final userId = ref.watch(userIdProvider);
    yield userId == post.userId;
  },
  name: 'canCurrentUserDeletePostProvider',
);
