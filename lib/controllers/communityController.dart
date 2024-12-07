import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:you_got_world/model/preCompleteGroundModel.dart';
import 'package:you_got_world/model/scorereModel.dart';
import 'package:you_got_world/repo/communityRepo.dart';
import 'package:you_got_world/services/sharedPrefs.dart';
import 'package:you_got_world/utils/utilsFunction.dart';

class CommunityController extends GetxController {
  CommunityRepo communityRepo = CommunityRepo();
  final SharedPreferencesController sharedPrefsController =
      Get.put(SharedPreferencesController());

  final RxInt selectedTabIndex = 0.obs;
  final RxList<GroundFacilities> groundFacilities = <GroundFacilities>[].obs;
  final RxList<PitchType> pitchType = <PitchType>[].obs;

  final minFees = ''.obs;
  final selectedCity = ''.obs;
  final groundFacilietiesText = ''.obs;
  final pitchTypeText = ''.obs;
  var showOtherFacilityInput = false.obs;
  Rx<File?> imageFile = Rx<File?>(null);

  final maxFees = ''.obs;
  var isLoading = false.obs;
  var isDataLoad = false.obs;
  int currentPage = 1;
  RxBool hasMoreData = true.obs;

  RxList<Scorer> scorerData = <Scorer>[].obs;

  final selectedPitchTypes = <String>[].obs;
  final selectedFacilities = <String>[].obs;

  final citySuggestions = <String>[
    'Delhi',
    'Mumbai',
    'Bangalore',
    'Chennai',
    'Kolkata',
    'Hyderabad',
    'Pune',
    'Ahmedabad',
    'Jaipur',
    'Lucknow'
  ].obs;

  @override
  void onInit() {
    super.onInit();

    scorersApi(name: 'sus');
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.red,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop Image',
              aspectRatioLockEnabled: true,
            ),
          ],
        );

        if (croppedFile != null) {
          imageFile.value = File(croppedFile.path);
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onFacilityChanged(bool? isSelected, String facilityName) {
    if (facilityName == 'Others') {
      showOtherFacilityInput.value = isSelected ?? false;
    }
  }

  List<String> getFilteredCities(String query) {
    return citySuggestions
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  bool validateFees() {
    if (minFees.value.isEmpty || maxFees.value.isEmpty) return true;
    return int.parse(minFees.value) <= int.parse(maxFees.value);
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void togglePitchType(String id, bool isSelected) {
    if (isSelected) {
      selectedPitchTypes.add(id);
    } else {
      selectedPitchTypes.remove(id);
    }
  }

  void toggleFacility(String id, bool isSelected) {
    if (isSelected) {
      selectedFacilities.add(id);
    } else {
      selectedFacilities.remove(id);
    }
  }

  void setFacilieties(List<String> value) {
    groundFacilietiesText.value = value.join(', ');
  }

  void setPitchType(List<String> value) {
    pitchTypeText.value = value.join(', ');
  }

  //   Apis  ---

  Future<void> scorersApi({
    bool isRefresh = false,
    required String name,
  }) async {
    if (isLoading.value || !hasMoreData.value) return;

    try {
      final token = await sharedPrefsController.getToken();

      if (isRefresh) {
        currentPage = 1;
        hasMoreData.value = true;
        scorerData.clear();
      }

      // isLoading.value = true;

      final newData = await communityRepo.scorersApi(token!, name, currentPage);

      if (newData.data!.scorer!.isNotEmpty) {
        scorerData.addAll(newData.data!.scorer!);
        currentPage++;
      } else {
        hasMoreData.value = false;
      }
    } catch (error) {
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  // --- Ground Api ---

  Future<void> preGroundDataApi() async {
    final controller = await Get.put(SharedPreferencesController());
    groundFacilities.clear();
    pitchType.clear();
    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();

      var response = await communityRepo.AddCompleteGroundDataApi(token!);
      if (response.status == 200 || response.status == 201) {
        groundFacilities.addAll(response.data!.groundFacilities!.toList());
        pitchType.addAll(response.data!.pitchType!.toList());

        print(response);
      }
      isDataLoad.value = false;
    } catch (e) {
      isDataLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addFullGroundApi(
      String ground_name,
      ground_address,
      contact_person,
      primary_contact_no,
      secondary_contact_no,
      email_id,
      shortes_length,
      longest_length,
      facilities,
      pitch_type,
      min_fee,
      max_fee) async {
    final controller = await Get.put(SharedPreferencesController());
    groundFacilities.clear();
    pitchType.clear();
    try {
      isLoading.value = true;
      String? token = await controller.getToken();

      var response = await communityRepo.AddCompleteGroundApi(
          token!,
          ground_name,
          ground_address,
          contact_person,
          primary_contact_no,
          secondary_contact_no,
          email_id,
          shortes_length,
          longest_length,
          facilities,
          pitch_type,
          min_fee,
          max_fee);
      if (response.status == 200 || response.status == 201) {
        Utils.toastMessage(response.message.toString());

        print(response);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void resetFields() {
    selectedFacilities.clear();
    selectedPitchTypes.clear();

    groundFacilietiesText.value = '';
    pitchTypeText.value = '';
  }

  // ---

  Future<void> addScorerApi(
    File? profileImagePath,
    String scorer_phone,
    String fee_per_match,
    String fee_per_day,
    String name,
    String total_expriance,
    String city_id,
  ) async {
    final controller = await Get.put(SharedPreferencesController());
    groundFacilities.clear();
    pitchType.clear();
    try {
      isLoading.value = true;
      String? token = await controller.getToken();

      var response = await communityRepo.addScorerApi(
          profileImagePath,
          token!,
          scorer_phone,
          fee_per_match,
          fee_per_day,
          name,
          total_expriance,
          city_id);
      if (response.status == 200 || response.status == 201) {
        Utils.toastMessage(response.message.toString());
        Get.back();

        print(response);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
