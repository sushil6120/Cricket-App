import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:you_got_world/controllers/powerPlayController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/widget/redButton.dart';

class PowerPlayView extends StatelessWidget {
  int? overs;
PowerPlayController controller;
  PowerPlayView({Key? key, this.overs, required this.controller}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    controller.initializeOvers(overs!);

    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
          backgroundColor: colorLightWhite,
          surfaceTintColor: colorLightWhite,
          elevation: .5,
          shadowColor: Colors.grey,
          title: Text(
            'Select Power Play Overs',
            style: TextStyle(
              fontSize: context.deviceHeight * .020,
              fontWeight: FontWeight.w500,
            ),
          )),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildPowerPlayGrid(0, 'POWER PLAY 1'),
                  buildPowerPlayGrid(1, 'POWER PLAY 2'),
                  buildPowerPlayGrid(2, 'POWER PLAY 3'),

                  // Obx(() => Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(controller.getAllSelectedOversText()),
                  //     )),
                ],
              ),
            ),
          ),
          SizedBox(
            width: context.deviceWidth * .95,
            child: RedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Done'),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildPowerPlayGrid(int powerPlayIndex, String title) {
    return Obx(() {
      final selectedOvers = powerPlayIndex == 0
          ? controller.powerPlay1Overs
          : powerPlayIndex == 1
              ? controller.powerPlay2Overs
              : controller.powerPlay3Overs;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: selectedOvers.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => controller.selectOver(powerPlayIndex, index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: selectedOvers[index] == 1
                      ? primaryColor.withOpacity(.8)
                      : Colors.white,
                  border: Border.all(color: colorDark3),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedOvers[index] == 1
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
