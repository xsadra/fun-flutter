import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../components/animated_bar.dart';
import '../components/side_menu.dart';
import '../constants.dart';
import '../models/menu_button.dart';
import '../models/rive_asset.dart';
import '../utils/rive_utils.dart';
import 'home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedNav = bottomNavAssets.first;

  late AnimationController _animatedContainer;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  late SMIBool isSideBarClosed;

  bool isSlideMenuClose = true;

  @override
  void initState() {
    _animatedContainer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animatedContainer,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animatedContainer,
        curve: Curves.fastOutSlowIn,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animatedContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            left: isSlideMenuClose ? -288 : 0,
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: const SideMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: isSlideMenuClose
                      ? BorderRadius.zero
                      : const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                  child: const HomeScreen(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSlideMenuClose ? 0 : 220,
            child: MenuButton(
              onInit: (value) {
                StateMachineController controller = RiveUtils.getController(
                  value,
                  stateMachineName: "State Machine",
                );
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },
              onTap: () {
                isSideBarClosed.value = !isSideBarClosed.value;
                if (isSlideMenuClose) {
                  _animatedContainer.forward();
                } else {
                  _animatedContainer.reverse();
                }

                setState(() {
                  isSlideMenuClose = isSideBarClosed.value;
                });
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, animation.value * 100),
        child: SafeArea(
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
      ),
    );
  }
}
