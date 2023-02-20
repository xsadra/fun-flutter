import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../core/log/logger.dart';
import '../../models/app_error.dart';
import '../../repositories/repositories.dart';
import '../providers.dart';
import 'state.dart';

final _authServiceProvider = StateNotifierProvider<AuthService, AuthState>(
  (ref) => AuthService(ref),
);

class AuthService extends StateNotifier<AuthState> {
  AuthService(this._ref)
      : super(
          const AuthState.unauthenticated(
            isLoading: true,
          ),
        ) {
    refresh();
  }

  static StateNotifierProvider<AuthService, AuthState> get provider =>
      _authServiceProvider;

  final Ref _ref;

  Future<void> refresh() async {
    try {
      final account = await _ref.read(Repository.auth).get();
      setAccount(account);
    } on RepositoryException catch (e) {
      logger.warning('Failed to refresh account: $e');
      state = const AuthState.unauthenticated();
    }
  }

  void setAccount(models.Account account) {
    logger.info('Authentication successful, setting $account');
    state = state.copyWith(
      account: account,
      isLoading: false,
    );
  }

  Future<void> signOut() async {
    try {
      await _ref.read(Repository.auth).deleteSession(sessionId: 'current');
      logger.info('Signed out successfully');
      state = const AuthState.unauthenticated();
    } on RepositoryException catch (e) {
      logger.warning('Failed to sign out: $e');
      state = state.copyWith(
        error: AppError(message: e.message),
      );
    }
  }
}

class AuthState extends StateBase {
  const AuthState({
    this.account,
    this.isLoading = false,
    AppError? error,
  }) : super(error: error);

  final models.Account? account;
  final bool isLoading;

  const AuthState.unauthenticated({
    this.isLoading = false,
  })  : account = null,
        super(error: null);

  bool get isAuthenticated => account != null;

  AuthState copyWith({
    models.Account? account,
    bool? isLoading,
    AppError? error,
  }) {
    return AuthState(
      account: account ?? this.account,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [account, isLoading, error];
}
