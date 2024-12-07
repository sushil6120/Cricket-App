import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PowerPlayController extends GetxController {
  late RxList<int> powerPlay1Overs;
  late RxList<int> powerPlay2Overs;
  late RxList<int> powerPlay3Overs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeOvers(0);
  }

  void initializeOvers(int numberOfOvers) {
    powerPlay1Overs = RxList<int>.filled(numberOfOvers, 0);
    powerPlay2Overs = RxList<int>.filled(numberOfOvers, 0);
    powerPlay3Overs = RxList<int>.filled(numberOfOvers, 0);
  }

  void selectOver(int powerPlayIndex, int overIndex) {
    if (overIndex < 0 || overIndex >= powerPlay1Overs.length) {
      Fluttertoast.showToast(
        msg: "Invalid over index.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    if (powerPlayIndex == 1) {
      if (!powerPlay1Overs.contains(1)) {
        Fluttertoast.showToast(
          msg: "Please select an over in Power Play 1 first.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      } else if (powerPlay1Overs[overIndex] == 1) {
        Fluttertoast.showToast(
          msg: "This over is already selected in Power Play 1.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }
    } else if (powerPlayIndex == 2) {
      if (!powerPlay2Overs.contains(1)) {
        Fluttertoast.showToast(
          msg: "Please select an over in Power Play 2 first.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      } else if (powerPlay1Overs[overIndex] == 1 ||
          powerPlay2Overs[overIndex] == 1) {
        Fluttertoast.showToast(
          msg: "This over is already selected in a previous Power Play.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }
    } else if (powerPlayIndex == 0) {
      if (powerPlay2Overs[overIndex] == 1 || powerPlay3Overs[overIndex] == 1) {
        Fluttertoast.showToast(
          msg: "This over is already selected in Power Play 2 or 3.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return;
      }
    }
    switch (powerPlayIndex) {
      case 0:
        powerPlay1Overs[overIndex] = powerPlay1Overs[overIndex] == 1 ? 0 : 1;
        break;
      case 1:
        powerPlay2Overs[overIndex] = powerPlay2Overs[overIndex] == 1 ? 0 : 1;
        break;
      case 2:
        powerPlay3Overs[overIndex] = powerPlay3Overs[overIndex] == 1 ? 0 : 1;
        break;
    }

    update();
  }

  String getSelectedOversText(RxList<int> powerPlayOvers) {
    List<String> selectedOvers = [];
    for (int i = 0; i < powerPlayOvers.length; i++) {
      if (powerPlayOvers[i] == 1) {
        selectedOvers.add(i.toString());
      }
    }
    return selectedOvers.isNotEmpty ? selectedOvers.join(', ') : "None";
  }

  // String getAllSelectedOversText() {
  //   String powerPlay1Text = getSelectedOversText(powerPlay1Overs);
  //   String powerPlay2Text = getSelectedOversText(powerPlay2Overs);
  //   String powerPlay3Text = getSelectedOversText(powerPlay3Overs);

  //   return "Power Play 1 Selected Overs: $powerPlay1Text\n"
  //       "Power Play 2 Selected Overs: $powerPlay2Text\n"
  //       "Power Play 3 Selected Overs: $powerPlay3Text";
  // }

  int get totalSelectedOvers =>
      powerPlay1Overs.where((o) => o == 1).length +
      powerPlay2Overs.where((o) => o == 1).length +
      powerPlay3Overs.where((o) => o == 1).length;

  void onDone() {
    // Handle final selections
  }

  void limitTextInput(TextEditingController controller, int maxValue) {
    controller.addListener(() {
      int currentValue = int.tryParse(controller.text) ?? 0;

      if (currentValue > maxValue) {
        controller.text = '$maxValue';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    });
  }
}
