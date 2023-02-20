import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/log/logger.dart';

void main() {
  initLogger();

  runApp(
    const ProviderScope(
      child: GoogleDocApp(),
    ),
  );
}
