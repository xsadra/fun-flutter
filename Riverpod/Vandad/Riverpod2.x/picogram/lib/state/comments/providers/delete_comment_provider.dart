import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart' show IsLoading, DeleteCommentNotifier;

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsLoading>(
  (_) => DeleteCommentNotifier(),
);
