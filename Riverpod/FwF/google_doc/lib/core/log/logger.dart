import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

final logger = Logger('App');

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    String emoji = '';
    if (record.level == Level.SEVERE) {
      emoji = '🔥';
    } else if (record.level == Level.WARNING) {
      emoji = '⚠️';
    } else if (record.level == Level.INFO) {
      emoji = 'ℹ️';
    } else if (record.level == Level.ALL) {
      emoji = '🔊';
    }
    debugPrint('$emoji ${record.level.name}: ${record.message}');
    if (record.error != null) {
      debugPrint('Error: ${record.error}');
    }

    if (record.level == Level.SEVERE) {
      debugPrintStack(stackTrace: record.stackTrace);
    }
  });
}
