import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../view/bottomNavbar.dart';
import '../view/onBoardingScreen.dart';

class SharedPreferencesController extends GetxController {
  String? userToken;
  String? team_id;
  String? opponentTeamId;
  String? userId;
  SharedPreferences? preferences;

  @override
  void onInit() {
    super.onInit();
    initSharedPreference();
  }

  Future<void> initSharedPreference() async {
    try {
      preferences = await SharedPreferences.getInstance();
      await getSharedPreference();

      if (userToken != null && userToken!.isNotEmpty) {
        Get.offAll(() => BottomNavBar(), transition: Transition.rightToLeft);
      } else {
        Get.offAll(() => OnboardingScreen(),
            transition: Transition.rightToLeft);
      }
    } catch (e) {
      print("Error initializing SharedPreferences: $e");
    }
  }

  Future<void> getSharedPreference() async {
    userToken = preferences?.getString('token') ?? '';
    userId = preferences?.getString('userId') ?? '';
  }

  Future<void> saveToken(String? token) async {
    await preferences?.setString('token', token!);
    userToken = token;
    update();
  }

  Future<void> saveUserName(String? token) async {
    await preferences?.setString('UserName', token!);

    update();
  }

  Future<void> saveUserImage(String? token) async {
    await preferences?.setString('saveUserImage', token!);

    update();
  }

  Future<void> saveLocation(String? token) async {
    await preferences?.setString('location', token!);
    userToken = token;
    update();
  }

  Future<void> saveTeamId(String? teamId) async {
    await preferences?.setString('teamId', teamId!);
    team_id = teamId;
    update();
  }

  Future<void> saveOpponentTeamId(String? oppoTeamId) async {
    await preferences?.setString('oppoTeamId', oppoTeamId!);
    opponentTeamId = oppoTeamId;
    update();
  }

  Future<void> saveAvtar(String? token) async {
    await preferences?.setString('avtar', token!);
    userToken = token;
    update();
  }

  Future<void> saveUserId(String? id) async {
    await preferences?.setString('userId', id!);
    userId = id;
    update();
  }

  Future<void> savePhone(String? id) async {
    await preferences?.setString('Phone', id!);

    update();
  }

  Future<String?> getToken() async {
    return preferences?.getString('token');
  }

  Future<String?> getPhone() async {
    return preferences?.getString('Phone');
  }

  Future<String?> getUserName() async {
    return preferences?.getString('UserName');
  }

  Future<String?> getLocation() async {
    return preferences?.getString('location');
  }

  Future<String?> getUserImage() async {
    return preferences?.getString('saveUserImage');
  }

  Future<String?> getTeamId() async {
    return preferences?.getString('teamId');
  }

  Future<String?> getOpponentTeamId() async {
    return preferences?.getString('oppoTeamId');
  }

  Future<String?> getAvtar() async {
    return preferences?.getString('avtar');
  }

  Future<String?> getUserId() async {
    return preferences?.getString('userId');
  }

  Future<void> logout() async {
    await preferences?.clear();
    userToken = '';
    userId = '';
    update(); // Notify listeners
  }

  Future<void> removeData(String key) async {
    await preferences?.remove(key);

    update(); // Notify listeners
  }
}
