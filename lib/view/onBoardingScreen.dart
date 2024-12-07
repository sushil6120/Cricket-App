import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/login_optionScreen.dart';
import 'package:you_got_world/view/widget/redButton.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/img/on1.png',
    'assets/img/on2.png',
    'assets/img/on3.png',
  ];

  final List<String> _texts = [
    'Player 1 - The Legend',
    'Player 2 - The Icon',
    'Player 3 - The Prodigy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Container(
        width: context.deviceWidth,
        child: Stack(
          children: [
            // Wave background image
            Positioned.fill(
              left: context.deviceWidth * .5,
              bottom: context.deviceHeight * .04,
              top: -80,
              child: Image.asset(
                'assets/img/wave.png',
                fit: BoxFit.contain,
                height: context.deviceHeight * .014,
                width: context.deviceHeight * .014,
              ),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: context.deviceWidth * .04, bottom: 20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return AnimatedBuilder(
                        animation: animation,
                        child: child,
                        builder: (context, child) {
                          final angle = (1 - animation.value) * pi;
                          return Transform(
                            transform: Matrix4.rotationY(angle),
                            alignment: Alignment.center,
                            child: angle > pi / 2 ? Container() : child,
                          );
                        },
                      );
                    },
                    child: Transform.flip(
                      flipX: _currentIndex == 1 ? true : false,
                      child: Image.asset(
                        _images[_currentIndex],
                        key: ValueKey<int>(_currentIndex),
                        height: context.deviceHeight * .6,
                        width: context.deviceHeight * .6,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Text under the image
            Positioned(
              bottom: 10,
              child: Container(
                height: context.deviceHeight * .32,
                width: context.deviceWidth,
                padding: EdgeInsets.only(top: context.actualHeight * .05),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/faded.png'))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: context.deviceHeight * .085),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'keep an eye on the stadium',
                                key: ValueKey<int>(_currentIndex),
                                style: TextStyle(
                                    fontSize: context.deviceHeight * .038,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                'Watch sports live or highlights, read\nevery news from your smartphone',
                                key: ValueKey<int>(_currentIndex),
                                style: TextStyle(
                                    fontSize: context.deviceHeight * .018,
                                    fontWeight: FontWeight.w400),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: context.deviceWidth * .2,
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * .95,
            child: RedButton(
                onPressed: () {
                  if (_currentIndex < 2) {
                    setState(() {});
                    setState(() {
                      _currentIndex = (_currentIndex + 1) % _images.length;
                    });
                  } else {
                    Get.to(const LoginOptionScreen(),
                        transition: Transition.rightToLeft);
                  }
                },
                text: 'Next'),
          ),
        ),
      ),
    );
  }
}
