import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:you_got_world/repo/authRepo.dart';
import 'package:you_got_world/services/sharedPrefs.dart';
import 'package:you_got_world/utils/utilsFunction.dart';
import 'package:geolocator/geolocator.dart';

import '../view/bottomNavbar.dart';
import '../view/verification/signUpOtpScreen.dart';

class AuthController extends GetxController {
  AuthRepo authRepo = AuthRepo();

  final otpController = TextEditingController();

  var loginLoad = false.obs;
  var registerLoad = false.obs;
  var otpLoad = false.obs;
  var fakeLoad = false.obs;

  var lat = 0.0.obs;
  var long = 0.0.obs;
  var deviceId = "".obs;
  var otpCode = "".obs;

  Future<void> loginApis(String phone) async {
    loginLoad.value = true;
    await getCurrentPosition();
    await getDeviceId();
    try {
      if (deviceId.value.isNotEmpty || deviceId.value != "") {
        var response = await authRepo.loginApi(
            phone, deviceId.value, lat.value, long.value);
        loginLoad.value = false;
        if (response.status == 200 &&
                response.message == "Verify your phone number" ||
            response.message == "Verify your phone using otp - 9999") {
          Get.to(
              () => SignUpOtpScreen(
                    phoneNumber: phone,
                  ),
              transition: Transition.rightToLeft);
        }
        Utils.toastMessage(response.message.toString());
      } else {
        Utils.toastMessage("Something went wrong try again");
      }
    } catch (e) {
      loginLoad.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> resendOtpApis(String phone) async {
    loginLoad.value = true;
    await getCurrentPosition();
    await getDeviceId();
    try {
      if (deviceId.value.isNotEmpty || deviceId.value != "") {
        var response = await authRepo.resendOtpApi(
            phone, deviceId.value, lat.value, long.value);
        loginLoad.value = false;

        Utils.toastMessage(response.message.toString());
      } else {
        Utils.toastMessage("Something went wrong try again");
      }
    } catch (e) {
      loginLoad.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> otpVerifyApis(String phone, otp) async {
    final controller = await Get.put(SharedPreferencesController());
    otpLoad.value = true;
    await getCurrentPosition();
    await getDeviceId();
    try {
      if (deviceId.value.isNotEmpty || deviceId.value != "") {
        var response = await authRepo.otpVerifyApi(
            phone, otp, deviceId.value, lat.value, long.value);
        otpLoad.value = false;
        if (response.status == 200 &&
            response.message == "Otp verify successfully") {
          controller.saveToken(response.data!.accessToken);
          controller.saveUserName(response.data!.userData![0].name.toString());
          controller.savePhone(response.data!.userData![0].phone.toString());
          controller.saveUserImage(
              response.data!.userData![0].profileImage.toString());
          controller
              .saveLocation(response.data!.userData![0].location.toString());
          Get.offAll(() => BottomNavBar(), transition: Transition.rightToLeft);
        }
        Utils.toastMessage(response.message.toString());
      } else {
        Utils.toastMessage("Something went wrong try again");
      }
    } catch (e) {
      otpLoad.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  Future<void> registrationApi(String phone, name, email) async {
    registerLoad.value = true;
    await getCurrentPosition();
    await getDeviceId();
    try {
      if (deviceId.value.isNotEmpty || deviceId.value != "") {
        var response = await authRepo.registerApi(
            phone, deviceId.value, lat.value, long.value, name, email);
        registerLoad.value = false;
        if (response.status == 200 &&
            response.message == "Verify your phone number") {
          Get.to(
              () => SignUpOtpScreen(
                    phoneNumber: phone,
                  ),
              transition: Transition.rightToLeft);
        }
        Utils.toastMessage(response.message.toString());
      } else {
        Utils.toastMessage("Something went wrong try again");
      }
    } catch (e) {
      registerLoad.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  // ----- Update Profile --------

  Future<void> updateProfileApi(
    File? profileImagePath,
    String locationId,
    String dob,
    String email,
    String name,
    String phone,
    String playingRole,
    String battingStyle,
    String bollingStyle,
    String gender,
    String secretPin,
  ) async {
    final controller = await Get.put(SharedPreferencesController());
    registerLoad.value = true;

    try {
      String? token = await controller.getToken();
      var response = await authRepo.updateProfileApi(
          profileImagePath == null ? null : profileImagePath,
          token!,
          locationId,
          dob,
          email,
          name,
          phone,
          playingRole,
          battingStyle,
          bollingStyle,
          gender,
          secretPin);
      registerLoad.value = false;
      if (response.status == 200) {
        Utils.toastMessage(response.message.toString());
      }
    } catch (e) {
      registerLoad.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  // ------- Locations -------

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'Location Services Disabled',
        'Location services are disabled. Please enable the services.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          'Location Permission Denied',
          'Location permissions are denied. Please allow them.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () => requestPermissionAgain(),
            child: Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Location Permission Denied Forever',
        'Location permissions are permanently denied. Please enable them from settings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  void requestPermissionAgain() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar(
        'Location Permission Denied',
        'Location permissions are denied. Please allow them.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        mainButton: TextButton(
          onPressed: () => requestPermissionAgain(),
          child: Text('Retry', style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat.value = position.latitude.toDouble();
      long.value = position.longitude.toDouble();

      print("========================================");
      print("lat : ${lat.value}");
      print("long : ${long.value}");
      print("========================================");

      return position;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  // ---- Device Id -----

  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId.value = androidInfo.id;
      print("Device ID : ${deviceId.value}");
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId.value = iosInfo.identifierForVendor!;
      print("Device ID : ${deviceId.value}");
    }
  }
}
