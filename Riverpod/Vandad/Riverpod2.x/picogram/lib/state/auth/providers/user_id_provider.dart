import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../posts/typedef/user_id.dart';
import 'auth_state_provider.dart';

part 'user_id_provider.g.dart';

@riverpod
UserId? userId(UserIdRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState.userId;
}
