
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../models/app_error.dart';
import '../../../repositories/repositories.dart';
import '../../controller_state_base.dart';

final _loginControllerProvider =
StateNotifierProvider<LoginController, ControllerStateBase>(
      (ref) => LoginController(ref),
);

class LoginController extends StateNotifier<ControllerStateBase> {
  LoginController(this._ref) : super(const ControllerStateBase());

  static StateNotifierProvider<LoginController, ControllerStateBase>
  get provider => _loginControllerProvider;

  static AlwaysAliveRefreshable<LoginController> get notifier =>
      provider.notifier;

  final Ref _ref;

  Future<void> createSession({
    required String email,
    required String password,
  }) async {
    try {
      await _ref.read(Repository.auth)
          .createSession(email: email, password: password);

      final account = await _ref.read(Repository.auth).get();

      /// Sets the global app state user.
      _ref.read(AppState.auth.notifier).setAccount(account);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}