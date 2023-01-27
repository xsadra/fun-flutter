import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart';

final deleteCommentNotifierProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsLoading>(
  (_) => DeleteCommentNotifier(),
);
