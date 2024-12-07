import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import '../../controllers/navbarController.dart';

class CustomBottomNavBar extends StatelessWidget {
  final NavController navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: Platform.isIOS
            ? context.deviceHeight * .12
            : context.deviceHeight * .082,
        padding: EdgeInsets.only(
            top: context.deviceHeight * .015, left: 22, right: 22),
        decoration: BoxDecoration(
          color: colorLightWhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Home Icon
            GestureDetector(
              onTap: () => navController.changeTabIndex(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: navController.currentIndex.value == 0
                        ? secondaryColor
                        : Colors.grey,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .014,
                      color: navController.currentIndex.value == 0
                          ? secondaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Search Icon
            GestureDetector(
              onTap: () => navController.changeTabIndex(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sports_cricket,
                    color: navController.currentIndex.value == 1
                        ? secondaryColor
                        : Colors.grey,
                  ),
                  Text(
                    'Book ground',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .014,
                      color: navController.currentIndex.value == 1
                          ? secondaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Profile Icon
            GestureDetector(
              onTap: () => navController.changeTabIndex(2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sports,
                    color: navController.currentIndex.value == 2
                        ? secondaryColor
                        : Colors.grey,
                  ),
                  Text(
                    'My Sports',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .014,
                      color: navController.currentIndex.value == 2
                          ? secondaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => navController.changeTabIndex(3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tv,
                    color: navController.currentIndex.value == 3
                        ? secondaryColor
                        : Colors.grey,
                  ),
                  Text(
                    'Movies',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .014,
                      color: navController.currentIndex.value == 3
                          ? secondaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => navController.changeTabIndex(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.wifi_tethering,
                    size: context.deviceHeight * .03,
                    color: navController.currentIndex.value == 4
                        ? secondaryColor
                        : Colors.grey,
                  ),
                  Text(
                    'Live',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .014,
                      color: navController.currentIndex.value == 4
                          ? secondaryColor
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
