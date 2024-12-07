import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabSwitchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var currentIndex = 0.obs;
  var screen = ''.obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  void changeTab(int index, String value) {
    currentIndex.value = index;
    screen.value = value;
    tabController.animateTo(index);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
