import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart';

final sendCommentNotifierProvider =
StateNotifierProvider<SendCommentNotifier, IsLoading>(
      (_) => SendCommentNotifier(),
);
