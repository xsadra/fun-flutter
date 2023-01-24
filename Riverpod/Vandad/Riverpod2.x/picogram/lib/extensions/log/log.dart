import 'package:flutter/foundation.dart' show debugPrint;

extension Log on Object {
  void log([String? message]) {
    debugPrint('$runtimeType: $message - ${toString()}');
  }
}