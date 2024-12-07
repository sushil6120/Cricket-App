import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/verification/loginScree.dart';
import 'package:you_got_world/view/verification/signUpOtpScreen.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

import '../../controllers/authController.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = AuthController();

  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>(); // Add this for form validation

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    numberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isNotEmpty) {
      if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+")
          .hasMatch(value.toString()))
        return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: colorLightWhite),
        centerTitle: true,
        title: Image.asset('assets/img/logos.png',
            height: context.deviceHeight * .06),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.deviceHeight * .16),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Text(
                  'joi',
                  style: TextStyle(
                    fontSize: context.deviceHeight * .124,
                    color: colorLightWhite.withOpacity(.1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: verticalSpaceMedium),
                        Text(
                          'Create your sportify id',
                          style: TextStyle(
                            fontSize: context.deviceHeight * .024,
                            color: colorLightWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Get news, game updates, highlights, and\nmore info on your favorite teams',
                          style: TextStyle(
                            fontSize: context.deviceHeight * .016,
                            color: colorLightWhite,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: verticalSpaceLarge),
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
          key: _formKey, // Add form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: verticalSpaceMedium),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, bottom: verticalSpaceMedium),
                child: TextFormFieldBig(
                  controller: nameController,
                  height: 50,
                  hintText: 'First Name',
                  maxLines: 1,
                  enabled: true,
                  fillColor: colorLight2,
                  isFill: true,
                  validator: _validateName, // Add validator
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, bottom: verticalSpaceMedium),
                child: TextFormFieldBig(
                  controller: lastNameController,
                  height: 50,
                  hintText: 'Last Name',
                  maxLines: 1,
                  enabled: true,
                  fillColor: colorLight2,
                  isFill: true,
                  validator: _validateLastName, // Add validator
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, bottom: verticalSpaceMedium),
                child: TextFormFieldBig(
                  controller: numberController,
                  keyboard: TextInputType.number,
                  height: 50,
                  hintText: 'Phone Number',
                  maxLines: 1,
                  enabled: true,
                  fillColor: colorLight2,
                  isFill: true,
                  formatters: [
                    // Limit to 10 digits
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: _validatePhone, // Add validator
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
                child: TextFormFieldBig(
                  controller: emailController,
                  height: 50,
                  hintText: 'Email Address',
                  maxLines: 1,
                  enabled: true,
                  fillColor: colorLight2,
                  isFill: true,
                  validator: _validateEmail, // Add validator
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isChecked,
                            activeColor: primaryColor,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                      const TextSpan(
                        text: ' I agree to the ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      const TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                      const TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                          text: '.', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: context.deviceHeight * .16,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                return SizedBox(
                  width: context.deviceWidth * .9,
                  child: RedButton(
                    isLoading: authController.registerLoad.value,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_isChecked) {
                          authController.registrationApi(
                              numberController.text,
                              "${nameController.text} ${lastNameController.text}",
                              emailController.text.isEmpty
                                  ? ''
                                  : emailController.text);
                        } else {
                          Get.snackbar("Terms & Conditions",
                              "You must agree to the terms and conditions.",
                              backgroundColor: secondaryColor,
                              colorText: colorLightWhite);
                        }
                      }
                    },
                    text: 'Sign up',
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
                      text: 'Already have an account?',
                      style: TextStyle(
                        color: colorDark2,
                        fontWeight: FontWeight.w400,
                        fontSize: context.deviceHeight * .016,
                      ),
                    ),
                    TextSpan(
                      text: ' Login',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: context.deviceHeight * .016,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => const LoginScreen(),
                              transition: Transition.rightToLeft);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
