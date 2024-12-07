import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/shimmerContainer.dart';
import 'package:you_got_world/view/homeScreen.dart';
import 'package:you_got_world/view/widget/redButton.dart';

import '../../../../controllers/squadController.dart';

class AddPlayerByNamePhoneScreen extends StatelessWidget {
  String? teamName, teamId, screen;
  AddPlayerByNamePhoneScreen(
      {super.key, required this.teamId, this.screen, required this.teamName});

  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  SquadController squadController = Get.put(SquadController());

  void onDonePressed() {
    if (phoneController.text.isEmpty || nameController.text.isEmpty) {
      Get.snackbar(
        colorText: colorLightWhite,
        backgroundColor: errorColor,
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    squadController.addPlayerApi(
        teamId!, phoneController.text, nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .2,
        shadowColor: colorDark3,
        surfaceTintColor: colorLightWhite,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          teamName!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Name Input
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Phone Number Input
              Row(
                children: [
                  // Country Code Container
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // Phone Number TextField
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Valid Phone Number',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Done Button
              Obx(
                () {
                  return SizedBox(
                    width: context.deviceWidth,
                    child: RedButton(
                        isLoading: squadController.isDataLoad.value,
                        onPressed: onDonePressed,
                        text: 'Done'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
