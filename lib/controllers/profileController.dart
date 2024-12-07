import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:you_got_world/model/locationLocalAreaModel.dart';
import 'package:you_got_world/model/profileParameterModel.dart';
import 'package:you_got_world/model/userProfileModel.dart';
import 'package:you_got_world/repo/profileRepo.dart';
import 'package:you_got_world/services/sharedPrefs.dart';

class ProfilController extends GetxController {
  ProfileRepo profileRepo = ProfileRepo();

  Rx<ProfileParameterModel> profileParameterModel =
      Rx<ProfileParameterModel>(ProfileParameterModel());
  Rx<UserProfileModel> userProfileModel =
      Rx<UserProfileModel>(UserProfileModel());

  RxList<Location> locationLocalAreaData = <Location>[].obs;

  RxBool isProfileLoading = RxBool(false);

  var isLoading = false.obs;
  var isLoad = false.obs;
  var locationLoad = false.obs;

  Future<void> profileParameterApis() async {
    final controller = await Get.put(SharedPreferencesController());

    try {
      String? token = await controller.getToken();

      isLoad.value = true;
      var response = await profileRepo.profileParameterApi(token.toString());
      profileParameterModel.value = response;
      isLoad.value = false;
    } catch (e) {
      if (kDebugMode) {
        isLoad.value = false;

        print(e.toString());
      }
    }
  }

  Future<void> userProfileApi() async {
    final controller = await Get.put(SharedPreferencesController());

    try {
      String? token = await controller.getToken();

      isLoading.value = true;
      var response = await profileRepo.userProfileApi(token.toString());
      userProfileModel.value = response;

      controller
          .saveUserName(userProfileModel.value.data!.first.name.toString());
      controller.savePhone(userProfileModel.value.data!.first.phone.toString());
      controller.saveUserImage(
          userProfileModel.value.data!.first.profileImage.toString());
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        isLoading.value = false;

        print(e.toString());
      }
    }
  }

  Future<void> locationLocalAreaApis(String searchKey) async {
    final controller = Get.put(SharedPreferencesController());
    locationLocalAreaData.clear(); // Clear the list before updating
    try {
      locationLoad.value = true;
      String? token = await controller.getToken();

      var response =
          await profileRepo.locationLocalAreaApi(token.toString(), searchKey);

      locationLocalAreaData.value = response.data!.location!.toList();

      locationLoad.value = false;
    } catch (e) {
      locationLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
