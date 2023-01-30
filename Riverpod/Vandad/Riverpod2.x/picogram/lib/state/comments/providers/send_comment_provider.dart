import 'package:hooks_riverpod/hooks_riverpod.dart' show StateNotifierProvider;

import '../../state.dart' show IsLoading, SendCommentNotifier;

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
  (_) => SendCommentNotifier(),
);
