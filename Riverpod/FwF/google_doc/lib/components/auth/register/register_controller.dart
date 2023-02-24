import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../models/app_error.dart';
import '../../../repositories/repositories.dart';
import '../../controller_state_base.dart';


final _registerControllerProvider =
StateNotifierProvider<RegisterController, ControllerStateBase>(
      (ref) => RegisterController(ref),
);

class RegisterController extends StateNotifier<ControllerStateBase> {
  RegisterController(this._ref) : super(const ControllerStateBase());

  static StateNotifierProvider<RegisterController, ControllerStateBase>
  get provider => _registerControllerProvider;

  static AlwaysAliveRefreshable<RegisterController> get notifier =>
      provider.notifier;

  final Ref _ref;

  Future<void> create({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final account = await _ref.read(Repository.auth)
          .create(email: email, password: password, name: name);

      await _ref.read(Repository.auth)
          .createSession(email: email, password: password);

      /// Sets the global app state user.
      _ref.read(AppState.auth.notifier).setAccount(account);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}