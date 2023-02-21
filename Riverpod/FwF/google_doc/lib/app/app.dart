import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'navigation/routes.dart';
import 'providers.dart';

final isAuthenticatedProvider = Provider<bool>(
  (ref) => ref.watch(AppState.auth).isAuthenticated,
);
final isAuthLoadingProvider = Provider<bool>(
  (ref) => ref.watch(AppState.auth).isLoading,
);

class GoogleDocApp extends ConsumerStatefulWidget {
  const GoogleDocApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GoogleDocAppState();
}

class _GoogleDocAppState extends ConsumerState<GoogleDocApp> {
  @override
  Widget build(BuildContext context) {
    final isAuthLoading = ref.watch(isAuthLoadingProvider);

    if (isAuthLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return MaterialApp.router(
      routeInformationParser: const RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          final isAuthenticated = ref.watch(isAuthenticatedProvider);

          return isAuthenticated? routesLoggedIn : routesLoggedOut;
        },
      ),
    );
  }
}
