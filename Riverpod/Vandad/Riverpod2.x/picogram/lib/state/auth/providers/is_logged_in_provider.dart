import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../state.dart';

part 'is_logged_in_provider.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
}
