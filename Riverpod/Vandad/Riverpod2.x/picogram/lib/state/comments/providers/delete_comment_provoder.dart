import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart';

final deleteCommentNotifierProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, IsLoading>(
  (_) => DeleteCommentStateNotifier(),
);
