import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'base_text.dart';
import 'link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> children;
  final TextStyle? styleForAll;

  const RichTextWidget({
    super.key,
    required this.children,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: children.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: baseText.style,
              recognizer: TapGestureRecognizer()..onTap = baseText.onTapped,
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: baseText.style,
            );
          }
        }).toList(),
      ),
    );
  }
}