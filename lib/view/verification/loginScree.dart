import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/authController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/splash_screen.dart';
import 'package:you_got_world/view/verification/signUpOtpScreen.dart';
import 'package:you_got_world/view/verification/signUpScreen.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key
  final numberController = TextEditingController();
  final AuthController authController = AuthController();

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  void _validateAndLogin() {
    if (_formKey.currentState?.validate() == true) {
      authController.loginApis(numberController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: colorLightWhite),
        centerTitle: true,
        title: Image.asset(
          'assets/img/logos.png',
          height: context.deviceHeight * .06,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.deviceHeight * .16),
          child: Stack(
            children: [
              Positioned(
                right: -context.deviceWidth * .12,
                top: -20,
                child: Text(
                  'Log',
                  style: TextStyle(
                      fontSize: context.deviceHeight * .124,
                      color: colorLightWhite.withOpacity(.1),
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: verticalSpaceMedium,
                        ),
                        Text(
                          'Welcome back!',
                          style: TextStyle(
                              fontSize: context.deviceHeight * .024,
                              color: colorLightWhite,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Get news, game updates highlights and\nmore info on your favorite teams',
                          style: TextStyle(
                              fontSize: context.deviceHeight * .016,
                              color: colorLightWhite,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: verticalSpaceLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assign the form key here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: verticalSpaceMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, bottom: verticalSpaceMedium),
                child: TextFormFieldBig(
                  formatters: [LengthLimitingTextInputFormatter(10)],
                  controller: numberController,
                  keyboard: TextInputType.phone,
                  height: 50,
                  hintText: 'Enter phone number',
                  maxLines: 1,
                  enabled: true,
                  fillColor: colorLight2,
                  isFill: true,
                  validator: (value) {
                    // Validate the phone number input
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: context.deviceHeight * .18,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                return SizedBox(
                  width: context.deviceWidth * .9,
                  child: RedButton(
                    isLoading: authController.loginLoad.value,
                    onPressed: _validateAndLogin,
                    text: 'Login',
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don’t have an account?',
                      style: TextStyle(
                          color: colorDark2,
                          fontWeight: FontWeight.w400,
                          fontSize: context.deviceHeight * .016),
                    ),
                    TextSpan(
                      text: ' SignUp',
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: context.deviceHeight * .018),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(SignUpScreen(),
                              transition: Transition.rightToLeft);
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
