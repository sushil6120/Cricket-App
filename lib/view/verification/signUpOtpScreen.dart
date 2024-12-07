import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:you_got_world/controllers/authController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/bottomNavbar.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:pinput/pinput.dart';

class SignUpOtpScreen extends StatefulWidget {
  String phoneNumber;
  SignUpOtpScreen({super.key, required this.phoneNumber});

  @override
  _SignUpOtpScreenState createState() => _SignUpOtpScreenState();
}

class _SignUpOtpScreenState extends State<SignUpOtpScreen> {
  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = AuthController();

  String _code = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    otpController.dispose();
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
                  top: -20,
                  child: Text(
                    'OT',
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
                            'OTP Verification',
                            style: TextStyle(
                                fontSize: context.deviceHeight * .024,
                                color: colorLightWhite,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Please enter OTP sent on +91 ${widget.phoneNumber}',
                            style: TextStyle(
                                fontSize: context.deviceHeight * .016,
                                color: colorLightWhite,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: verticalSpaceLarge,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: verticalSpaceLarge,
            ),
            Form(
              key: _formKey,
              child: Center(
                child: SizedBox(
                  width: context.deviceWidth * .7,
                  height: 60,
                  child: PinFieldAutoFill(
                    keyboardType: TextInputType.number,
                    autoFocus: true,
                    codeLength: 4,
                    controller: otpController,
                    decoration: BoxLooseDecoration(
                      gapSpace: 20,
                      radius: Radius.circular(10),
                      bgColorBuilder: FixedColorBuilder(colorLight2),
                      strokeColorBuilder: FixedColorBuilder(colorLight2),
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onCodeSubmitted: (code) {},
                    onCodeChanged: (code) {
                      if (code!.length == 4) {
                        authController.otpVerifyApis(
                            widget.phoneNumber, otpController.text);
                      }
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Didn’t Receive the Code? ',
                        style: TextStyle(
                            color: colorDark3,
                            fontWeight: FontWeight.w500,
                            fontSize: context.deviceHeight * .016),
                      ),
                      TextSpan(
                          text: 'Resend',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: context.deviceHeight * .016),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              authController.resendOtpApis(widget.phoneNumber);
                            }),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: verticalSpaceLarge + 10,
            ),
            Obx(
              () {
                return Center(
                  child: SizedBox(
                    width: context.deviceWidth * .9,
                    child: RedButton(
                      isLoading: authController.otpLoad.value,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authController.otpVerifyApis(
                              widget.phoneNumber, otpController.text);
                        }
                      },
                      text: 'Verify',
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
