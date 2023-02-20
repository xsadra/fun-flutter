import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/app/navigation/routes.dart';
import 'package:routemaster/routemaster.dart';

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
    return MaterialApp.router(
      routeInformationParser: const RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => routesLoggedOut,
      ),
    );
  }
}
