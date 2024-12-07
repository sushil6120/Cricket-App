import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/verification/loginScree.dart';
import 'package:you_got_world/view/verification/signUpScreen.dart';
import 'package:you_got_world/view/widget/redButton.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: AssetImage('assets/img/bg.png'))),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: context.deviceHeight * .02,
                  ),
                  child: Image.asset('assets/img/logos.png', height: context.deviceHeight*.1,),
                ),
              ),
              Container(
                width: context.deviceWidth,
                padding: EdgeInsets.only(top: context.deviceHeight * .11),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/img/faded.png'))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: verticalSpaceExtraSmall,
                    ),
                    Text(
                      'keep an eye on the\nstadium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: context.deviceHeight * .028,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: verticalSpaceExtraSmall,
                    ),
                    Text(
                      'Watch sports live or highlights, read\nevery news from your smartphone',
                      style: TextStyle(
                          fontSize: context.deviceHeight * .018,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: verticalSpaceMedium,
                    ),
                    SizedBox(
                      width: context.deviceWidth * .9,
                      child: RedButton(
                          onPressed: () {
                            Get.to(SignUpScreen(), transition:Transition.rightToLeft);
                          },
                          text: 'Sign up'),
                    ),
                    const SizedBox(
                      height: verticalSpaceExtraSmall + 5,
                    ),
                    SizedBox(
                      width: context.deviceWidth * .9,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(LoginScreen(), transition:Transition.rightToLeft);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,

                          foregroundColor: Colors.white,
                          backgroundColor:
                              colorLightWhite, // Set the text color to white
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          side: const BorderSide(color: primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: verticalSpaceExtraSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          height: context.deviceHeight * .08,
          child: Center(
            child: Text(
              'Sign up later',
              style: TextStyle(
                  color: colorDark3,
                  fontSize: context.deviceHeight * .018,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
