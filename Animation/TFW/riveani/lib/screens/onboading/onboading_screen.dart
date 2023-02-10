import 'dart:ui';

import 'package:arive/constants.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_button.dart';
import 'components/sign_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      'active',
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset(Assets.spline),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(Assets.shapesRive),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 270, // must be 160
                    child: Column(
                      children: const [
                        Text(
                          Strings.onboardingTitle,
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'Poppins',
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          Strings.onboardingSubtitle,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedButton(
                    animationController: _btnAnimationController,
                    onTap: () {
                      _btnAnimationController.isActive = true;

                      showGeneralDialog(
                        barrierDismissible: true,
                        barrierLabel: Strings.signInTitle,
                        context: context,
                        pageBuilder: (context, _, __) => Center(
                          child: Container(
                            height: 620,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.symmetric(
                              vertical: 32,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Column(
                                children: const [
                                  Text(
                                    Strings.signInTitle,
                                    style: TextStyle(
                                      fontSize: 34,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text(
                                      Strings.signInDescription,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  SignInForm(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      Strings.onboardingDescription,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
