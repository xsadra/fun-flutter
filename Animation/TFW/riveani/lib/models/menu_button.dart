import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onTap,
    required this.onInit,
  });

  final VoidCallback onTap;
  final ValueChanged<Artboard> onInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(left: 16, top: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
                // spreadRadius: 5,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            Assets.menuButtonRive,
            onInit: onInit,
          ),
        ),
      ),
    );
  }
}
