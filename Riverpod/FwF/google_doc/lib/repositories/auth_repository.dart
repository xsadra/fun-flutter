import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';
import '../core/log/logger.dart';
import 'repository_exception.dart';

final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref);
});

class AuthRepository with RepositoryExceptionMixin {
  const AuthRepository(this._ref);

  static Provider<AuthRepository> get provider => _authRepositoryProvider;

  final Ref _ref;

  Account get _account => _ref.read(Dependency.account);

  Future<models.Account> create({
    required String email,
    required String password,
    required String name,
  }) {
    logger.info('Creating new account with email: $email');
    return exceptionHandler(
      _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  Future<models.Session> createSession({
    required String email,
    required String password,
  }) {
    logger.info('Creating new session with email: $email');
    return exceptionHandler(
      _account.createEmailSession(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> deleteSession({
    required String sessionId,
  }) {
    logger.info('Deleting session with id: $sessionId');
    return exceptionHandler(
      _account.deleteSession(
        sessionId: sessionId,
      ),
    );
  }

  Future<models.Account> get() {
    logger.info('Getting account');
    return exceptionHandler(
      _account.get(),
    );
  }
}
