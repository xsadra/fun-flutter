import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'animations.dart' show LottieAnimation;

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.path,
        repeat: repeat,
        reverse: reverse,
      );
}

extension GetFullPath on LottieAnimation {
  String get path => 'assets/animations/$name.json';
}
