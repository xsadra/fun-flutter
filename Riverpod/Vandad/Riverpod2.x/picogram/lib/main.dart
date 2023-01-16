import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'state/auth/backend/authenticator.dart';
import 'state/auth/providers/auth_state_provider.dart';
import 'state/auth/providers/is_logged_in_provider.dart';

extension Log on Object {
  void log([String? message]) {
    debugPrint('$runtimeType: $message - ${toString()}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final isLoggedIn = ref.watch(isLoggedInProvider);
          return isLoggedIn ? const MainView() : const LoginView();
        },
      ),
    );
  }
}

class MainView extends ConsumerWidget {
  const MainView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicoGram'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authStateProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: const Center(),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateProvider).result?.log('authStateProvider');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
            child: const Text('Sign in with Google'),
          ),
          TextButton(
            onPressed: ref.read(authStateProvider.notifier).loginWithFacebook,
            child: const Text('Sign in with Facebook'),
          ),
          TextButton(
            onPressed: () async {
              await const Authenticator().signOut();
              log('Signed out');
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
