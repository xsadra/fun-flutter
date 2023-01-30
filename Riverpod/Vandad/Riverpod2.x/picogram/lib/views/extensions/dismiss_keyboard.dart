import 'package:flutter/material.dart' show FocusManager, Widget;

extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
