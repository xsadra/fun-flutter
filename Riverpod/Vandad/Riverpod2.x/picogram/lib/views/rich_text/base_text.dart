import 'package:flutter/material.dart'
    show Colors, TextDecoration, TextStyle, VoidCallback, immutable;
import 'package:picogram/views/rich_text/link_text.dart';

@immutable
class BaseText {
  const BaseText({
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(text: text, style: style);

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        style: style,
        onTapped: onTapped,
      );
}
