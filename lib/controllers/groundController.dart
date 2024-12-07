import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/model/searchGroundModel.dart';
import 'package:you_got_world/repo/groundRepo.dart';
import 'package:you_got_world/services/sharedPrefs.dart';

class GroundController extends GetxController {
  GroundRepo groundRepo = GroundRepo();

  RxList<Ground> searchGroundData = <Ground>[].obs;

  TextEditingController groundController = TextEditingController();

  var currentPage = 1.obs;
  var hasMoreData = true.obs;
  var isLoading = false.obs;

  var selectedGround = ''.obs;

  void setGround(String value) {
    selectedGround.value = value;
  }

  Future<void> searchGroundApi(String searchQuery,
      {bool isRefresh = false}) async {
    final controller = await Get.put(SharedPreferencesController());
searchGroundData.clear();
    String? token = await controller.getToken();
    print("sushil");
    // if (isLoading.value || !hasMoreData.value) return print("object");

    try {
      if (isRefresh) {
        currentPage.value = 1;
        hasMoreData.value = true;
        searchGroundData.clear();
        print('Refreshing search with query: $searchQuery');
      }

      isLoading.value = true;

      print('Fetching data with search query: $searchQuery and token: $token');

      final newData = await groundRepo.searchGroundApi(
          token!, searchQuery, 1);

      if (newData.data?.ground?.isNotEmpty ?? false) {
        searchGroundData.addAll(newData.data!.ground!.toList());
        // currentPage.value++;
        print('Fetched ${newData.data!.ground!.length} grounds');
      } else {
        hasMoreData.value = false;
        print('No more grounds available');
      }

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      print('Error fetching data: $error');
    }
  }
}
