import 'package:arive/constants.dart';
import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    required RiveAnimationController animationController,
    required this.onTap,
  }) : _animationController = animationController;

  final RiveAnimationController _animationController;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              Assets.buttonRive,
              controllers: [_animationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(width: 8),
                  Text(
                   Strings.animatedButtonText ,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
