import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../components/animated_bar.dart';
import '../constants.dart';
import '../models/rive_asset.dart';
import '../utils/rive_utils.dart';
import 'home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAsset selectedNav = bottomNavAssets.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: const HomeScreen(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavAssets.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavAssets[index].input!.change(true);
                    if (bottomNavAssets[index] != selectedNav) {
                      setState(() {
                        selectedNav = bottomNavAssets[index];
                      });
                    }
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      bottomNavAssets[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                          isActive: bottomNavAssets[index] == selectedNav),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              bottomNavAssets[index] == selectedNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavAssets.first.src,
                            artboard: bottomNavAssets[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getController(
                                artboard,
                                stateMachineName:
                                    bottomNavAssets[index].stateMachineName,
                              );
                              bottomNavAssets[index].input =
                                  controller.findSMI('active') as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
