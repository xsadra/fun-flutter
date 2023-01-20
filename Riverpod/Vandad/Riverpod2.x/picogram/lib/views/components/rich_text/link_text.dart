import 'package:flutter/foundation.dart' show VoidCallback, immutable;

import 'base_text.dart';

@immutable
class LinkText extends BaseText {
  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });

  final VoidCallback onTapped;
}
