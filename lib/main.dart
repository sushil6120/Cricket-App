import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_got_world/themes/thems.dart';
import 'package:you_got_world/view/splash_screen.dart';

SharedPreferences? preferences;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getThemeData(context),
      title: 'You Got World',
      home: const SplashScreen(),
    );
  }
}
