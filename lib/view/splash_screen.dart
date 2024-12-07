import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/services/sharedPrefs.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      final controller = await Get.put(SharedPreferencesController());
      controller.initSharedPreference();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          'assets/img/logos.png',
          height: context.deviceHeight * .3,
          width: context.deviceHeight * .3,
        ),
      ),
    );
  }
}
