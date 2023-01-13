import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:picogram/state/auth/backend/authenticator.dart';
import 'firebase_options.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicoGram'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                final result = await Authenticator().signInWithGoogle();
                result.log('Google sign in result');
              },
              child: const Text('Sign in with Google'),
            ),
            TextButton(
              onPressed: () async {
                final result = await Authenticator().loginWithFacebook();
                result.log('Facebook sign in result');
              },
              child: const Text('Sign in with Facebook'),
            ),
            TextButton(
              onPressed: () async {
                await Authenticator().signOut();
                log('Signed out');
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
