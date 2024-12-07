import 'package:get/get.dart';

class NavController extends GetxController {
  // Current selected index
  var currentIndex = 0.obs;

  // Update the current index
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
