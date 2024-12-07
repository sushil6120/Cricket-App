import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:you_got_world/controllers/profileController.dart';
import 'package:you_got_world/shimmer/profileShimmer.dart';
import 'package:you_got_world/view/qrCodeScreen.dart';
import 'package:you_got_world/view/widget/profileWidget/profileOptionWidget.dart';

import 'widget/profileWidget/accountActionWidget.dart';
import 'widget/profileWidget/premiumePlanBannerWidget.dart';
import 'widget/profileWidget/profileCompletionWidget.dart';
import 'widget/profileWidget/profileHeaderWidget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfilController profilController = Get.put(ProfilController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilController.userProfileApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code, color: Colors.white),
            onPressed: () {
              Get.to(QrCodeScreen(), transition: Transition.rightToLeft);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if (profilController.isLoading.value == true ||
                    profilController.userProfileModel.value.data == null) {
                  return Center(child: ProfileHeaderShimmer());
                } else {
                  return ProfileHeader(
                    userProfileModel: profilController.userProfileModel.value,
                  );
                }
              },
            ),
            ProfileOptions(),
            PremiumPlanBanner(),
            ProfileCompletion(),
            AccountActions(),
          ],
        ),
      ),
    );
  }
}
