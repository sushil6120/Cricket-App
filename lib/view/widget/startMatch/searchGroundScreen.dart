import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/groundController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

class SearchGroundScreen extends StatelessWidget {
  SearchGroundScreen({super.key});
  GroundController controller = Get.put(GroundController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: colorLightWhite,
        title: Text(
          'Select Ground',
          style: TextStyle(
            fontSize: context.deviceHeight * .016,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: .5,
        shadowColor: colorLight3,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: TextFormFieldBig(
              hintText: 'Search Ground',
              maxLines: 1,
              isFill: true,
              fillColor: colorLight2,
              onChanged: (String value) {
                print(value);

                Timer(const Duration(milliseconds: 500), () {
                  controller.searchGroundApi(value.toString());
                });
              },
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.searchGroundData.length,
                  itemBuilder: (context, index) {
                    var item = controller.searchGroundData[index];
                    return ListTile(
                      onTap: () {
                        controller.setGround(item.groundId.toString());
                        Get.back();
                      },
                      title: Text(item.groundName.toString()),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
