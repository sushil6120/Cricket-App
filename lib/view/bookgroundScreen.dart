import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/groundInfoScreen.dart';
import 'package:you_got_world/view/widget/groundWidget/goundAppBarWidget.dart';
import 'package:you_got_world/view/widget/groundWidget/groundTimeWidget.dart';
import 'package:you_got_world/view/widget/groundWidget/groundWidget.dart';

class BookGroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.deviceHeight * .16),
          child: BlurryContainer(
              borderRadius: BorderRadius.circular(0),
              blur: 300,
              color: Colors.white.withOpacity(.2),
              padding: EdgeInsets.only(top: context.deviceHeight * .03),
              child: SafeArea(child: GroundAppBarWidget()))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: context.deviceHeight * .236,
            ),
            GroundTImeWidget(),
            const SizedBox(height: 20),
            ...List.generate(
                5,
                (index) => GroundWidget(
                      onTap: () {
                        Get.to(GroundDetailScreen(),
                            transition: Transition.rightToLeft);
                      },
                    ))
          ],
        ),
      ),
    );
  }
}
