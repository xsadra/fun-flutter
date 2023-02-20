import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/repositories.dart';
import 'constants.dart';
import 'state/state.dart';


abstract class Dependency {
  static Provider<Client> get client => _clientProvider;
  static Provider<Account> get account => _accountProvider;
  static Provider<Databases> get database => _databaseProvider;
  static Provider<Realtime> get realtime => _realtimeProvider;
}

abstract class Repository{
  static Provider<AuthRepository> get auth => AuthRepository.provider;
}

abstract class AppState{
  static StateNotifierProvider<AuthService, AuthState> get auth => AuthService.provider;
}

final _clientProvider = Provider<Client>((ref) => Client()
  ..setProject(appwriteProjectId)
  ..setSelfSigned(status: true)
  ..setEndpoint(appwriteEndpoint));

final _accountProvider = Provider<Account>(
  (ref) => Account(ref.read(_clientProvider)),
);

final _databaseProvider = Provider<Databases>(
  (ref) => Databases(ref.read(_clientProvider)),
);

final _realtimeProvider = Provider<Realtime>(
  (ref) => Realtime(ref.read(_clientProvider)),
);
