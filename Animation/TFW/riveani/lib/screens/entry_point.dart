import 'package:arive/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Hello World'),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 36,
                width: 36,
                child: RiveAnimation.asset(
                  Assets.iconsRive,
                  artboard: 'HOME',
                  onInit: (artboard) {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
