import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart' show IsLoading, DeletePostStateNotifier;

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, IsLoading>(
  (_) => DeletePostStateNotifier(),
);
