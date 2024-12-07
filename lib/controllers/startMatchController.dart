import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:you_got_world/model/myTeamListModel.dart';
import 'package:you_got_world/model/teamPlayerModel.dart';
import 'package:you_got_world/repo/startMatchRepo.dart';
import 'package:you_got_world/services/sharedPrefs.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:you_got_world/view/tossScreen.dart';

import '../utils/utilsFunction.dart';

class StartMatchController extends GetxController {
  StartMatchRepo startMatchRepo = StartMatchRepo();

  RxList<TeamList> myTeamListData = <TeamList>[].obs;

  var isLoading = false.obs;
  var isDataLoad = false.obs;

  final selectedCity = Rxn<String>();
  final teamId = Rxn<String>();
  final teamLogo = Rxn<String>();
  final teamNameValue = Rxn<String>();
  final selectedCityId = Rxn<String>();
  final myTeamIndex = Rxn<int>();

  final teamName = ''.obs;
  final cityTown = ''.obs;
  final captainNumber = ''.obs;
  final captainName = ''.obs;

  final isInTeam = false.obs;
  final imageFile = Rxn<File>();
  final formKey = GlobalKey<FormState>();

  final searchQuery = ''.obs;
  final isDropdownOpen = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myTeamListApi();
  }

  void setMyTeamIndex(int index) {
    myTeamIndex.value = index;
    print(myTeamIndex.value);
  }

  void setMyTeamData(String teamid, teamlogo, teamname) {
    teamId.value = teamid;
    teamLogo.value = teamlogo;
    teamNameValue.value = teamname;
  }

  void selectCity(String city) {
    selectedCity.value = city;
    searchQuery.value = '';
    isDropdownOpen.value = false;
  }

  void selectCityId(String city) {
    selectedCityId.value = city;
    searchQuery.value = '';
    isDropdownOpen.value = false;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(),
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        imageFile.value = File(croppedFile.path);
      }
    }
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void submitForm(String name) {
    if (validateForm()) {
      if (selectedCityId.value == null) {
        Utils.toastMessage('Please Select City/town');
      } else {
        createTeamApi(imageFile.value, teamName.value, selectedCityId.value!,
                captainNumber.value, name, isInTeam.value == true ? '1' : '2')
            .then((value) {
          teamName.value = '';
          captainName.value = '';
          captainNumber.value = '';
          cityTown.value = '';
          imageFile.value = null;
          update();
        });
      }
    }
  }

  Future<void> createTeamApi(
    File? team_logo,
    String team_name,
    String location_city,
    String captain_phone_number,
    String captain_name,
    String self_add,
  ) async {
    final controller = await Get.put(SharedPreferencesController());
    isLoading.value = true;

    try {
      String? token = await controller.getToken();
      var response = await startMatchRepo.createTeamApi(
          team_logo,
          token!,
          team_name,
          location_city,
          captain_phone_number,
          captain_name,
          self_add);
      isLoading.value = false;
      if (response.status == 200 || response.status == 201) {
        myTeamListApi();
      }
      Utils.toastMessage(response.message.toString());
    } catch (e) {
      isLoading.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  // ------- Create Opponent Api -----

  Future<void> createOpponentTeamApi(
    File? team_logo,
    String team_name,
    String location_city,
    String captain_phone_number,
    String captain_name,
  ) async {
    final controller = await Get.put(SharedPreferencesController());
    isLoading.value = true;

    try {
      String? token = await controller.getToken();
      var response = await startMatchRepo.createOpponentTeamApi(
        team_logo,
        token!,
        team_name,
        location_city,
        captain_phone_number,
        captain_name,
      );
      isLoading.value = false;
      if (response.status == 200 || response.status == 201) {
        // opponentTeamListApi();
        print("Opponent");
      }
      Utils.toastMessage(response.message.toString());
    } catch (e) {
      isLoading.value = false;
      Utils.toastMessage(e.toString());
    }
  }

  // -----------

  Future<void> myTeamListApi() async {
    final controller = await Get.put(SharedPreferencesController());
    myTeamListData.clear();
    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();

      var response = await startMatchRepo.myTeamListApi(token!);
      myTeamListData.value.addAll(response.data!.teamList!.toList());
      isDataLoad.value = false;
    } catch (e) {
      isDataLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
