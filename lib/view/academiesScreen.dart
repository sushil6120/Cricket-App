import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/academyProfileScreen.dart';
import 'package:you_got_world/view/widget/academyCardWidget.dart';

import 'registerAcademyScreen.dart';
import 'widget/redButton.dart';

class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        elevation: .5,
        shadowColor: colorDark3,
        centerTitle: true,
        backgroundColor: colorLightWhite,
        surfaceTintColor: colorLightWhite,
        title: Text(
          "Academy",
          style: TextStyle(
            fontSize: context.deviceHeight * .020,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
                color: colorDark1,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_alt_outlined,
                color: colorDark1,
              )),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: verticalSpaceSmall),
              itemCount: 3,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AcademyCardWidget(
                  image: 'https://res.cloudinary.com/purnesh/image/upload/w_1080,f_auto/west-delhi-cricket-academy0.jpg',
                  title: 'Pankaj Cricket Club',
                  location: 'New Delhi',
                  price: '200.7',
                  onTap: () {
                    Get.to(AcademyProfileScreen(), transition: Transition.rightToLeft);
                  },
                );
              },
            ),
          ),
          Column(
          children: [
            SizedBox(
              width: context.deviceWidth * .9,
              child: RedButton(
                  onPressed: () {
                    Get.to(RegisterAcademyScreen(),
                        transition: Transition.rightToLeft);
                  },
                  text: 'Register Academy'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "*List your cricket here*",
              style: TextStyle(
                  fontSize: context.deviceHeight * .014,
                  color: colorDark3,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(height: 6,)
        ],
      ),
  


    );
  }
}
