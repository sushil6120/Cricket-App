import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/community/widget/emptyGroundWidget.dart';
import 'package:you_got_world/view/registerAcademyScreen.dart';

import 'groundRegistrationScreen.dart';

class CommunityGroundScreen extends StatelessWidget {
  const CommunityGroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: const BackButton(color: Colors.white),
        title: Text(
          'Community',
          style: TextStyle(
              color: colorLightWhite, fontSize: context.deviceHeight * .022),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BookMyGround',
                  style: TextStyle(
                    fontSize: context.deviceHeight * .018,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(GroundRegistrationScreen(),
                        transition: Transition.rightToLeft);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: primaryColor)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline_outlined,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            fontSize: context.deviceHeight * .016),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Text(
                  'Nearby ',
                  style: TextStyle(fontSize: context.deviceHeight * .016),
                ),
                Text(
                  'Padagha',
                  style: TextStyle(
                    fontSize: context.deviceHeight * .016,
                    color: primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '(Change)',
                    style: TextStyle(
                      fontSize: context.deviceHeight * .016,
                      color: primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 8),
                const Icon(Icons.swap_vert),
              ],
            ),
          ),
          SizedBox(
            height: verticalSpaceLarge,
          ),
          EmptyGroundWidget()
        ],
      ),
    );
  }
}
