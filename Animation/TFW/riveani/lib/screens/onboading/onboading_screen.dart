import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_button.dart';

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
            child: Image.asset('assets/Backgrounds/Spline.png'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
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
                    width: 260,
                    child: Column(
                      children: const [
                        Text(
                          'Here is lovely Vet-Pet',
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'Poppins',
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text("The aim is to create an electronic health"
                            " record for pets. In addition to parameters"
                            " that are filled in by the pet owner himself,"
                            " relevant parameters from the pet's stool"
                            " analysis are included in the pet's health"
                            " dashboard after a subscription has been"
                            " taken out."),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedButton(
                    animationController: _btnAnimationController,
                    onTap: () {
                      _btnAnimationController.isActive = true;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      "This dashboard is the heart of "
                      "the interface and gives a quick overview "
                      "of the animal's most important health "
                      "parameters.",
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
