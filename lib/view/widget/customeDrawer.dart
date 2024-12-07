import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/profileController.dart';
import 'package:you_got_world/services/sharedPrefs.dart';
import 'package:you_got_world/shimmer/drawerProifleShimmer.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/community/communityScreen.dart';
import 'package:you_got_world/view/profileScreen.dart';
import 'package:you_got_world/view/qrCodeScreen.dart';
import 'package:you_got_world/view/verification/loginScree.dart';

import '../../themes/colors.dart';
import '../academiesScreen.dart';
import '../selectTeamsScreens.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  ProfilController profilController = Get.put(ProfilController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilController.userProfileApi();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedPreferencesController());
    return Drawer(
      backgroundColor: colorLightWhite,
      width: context.deviceWidth * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: primaryColor),
            child: Padding(
                padding: EdgeInsets.only(
                    top: context.deviceHeight * .08, left: 16, bottom: 40),
                child: Obx(
                  () {
                    if (profilController.isLoading.value == true|| profilController
                                                .userProfileModel!
                                                .value
                                                .data== null) {
                      return DrawerProfileHeaderShimmer();
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(ProfileScreen(),
                                  transition: Transition.rightToLeft);
                            },
                            child: CircleAvatar(
                                radius: 33,
                                backgroundColor: primaryColor,
                                backgroundImage: profilController
                                                .userProfileModel!
                                                .value
                                                .data!
                                                .first
                                                .profileImage ==
                                            null ||
                                        profilController.userProfileModel!.value
                                            .data!.first.profileImage!.isEmpty
                                    ? NetworkImage(
                                        'https://media.gettyimages.com/id/166080748/vector/cricket-player-strikes-the-ball-for-six.jpg?s=612x612&w=gi&k=20&c=V-kwBs62Vum3JsjZTDYTsXeyvA1Q0-ECKwuq8m39hTg=')
                                    : NetworkImage(profilController
                                        .userProfileModel!
                                        .value
                                        .data!
                                        .first
                                        .profileImage
                                        .toString())),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            profilController.userProfileModel!.value
                                            .data!.first.name.toString(),
                                style: TextStyle(
                                  fontSize: context.deviceHeight * .018,
                                  color: colorLightWhite,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: colorLightWhite,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '(+91) ${ profilController.userProfileModel!.value
                                            .data!.first.phone!}',
                                    style: TextStyle(
                                        fontSize: context.deviceHeight * .016,
                                        color: colorLightWhite,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(ProfileScreen(),
                                      transition: Transition.rightToLeft);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      color: colorLightWhite,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'View Profile',
                                      style: TextStyle(
                                          fontSize: context.deviceHeight * .016,
                                          color: colorLightWhite,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(QrCodeScreen(),
                                      transition: Transition.rightToLeft);
                                },
                                child: Icon(
                                  Icons.qr_code,
                                  color: colorLightWhite,
                                )),
                          )
                        ],
                      );
                    }
                  },
                )),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home_outlined,
                  text: 'lorem',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.person,
                  text: 'lorem',
                  onTap: () {
                    // Get.to(const ProfileScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.person,
                  text: 'Academy',
                  onTap: () {
                    Get.to(const AcademyScreen(),
                        transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.person,
                  text: 'Start A Match',
                  onTap: () {
                    Get.to(SelectTeamsScreens(),
                        transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.bell,
                  text: 'lorem',
                  onTap: () {
                    // Get.to(const NotificationScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.person,
                  text: 'lorem',
                  onTap: () {
                    //  Get.to(const MyPaymentScreem(),
                    //     transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.share_outlined,
                  text: 'Community',
                  onTap: () {
                    Get.to(CricketCommunityScreen(),
                        transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.heart,
                  text: 'lorem',
                  onTap: () {
                    // Get.to(const WishListScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.mode_edit_outlined,
                  text: 'lorem',
                  onTap: () {
                    // Get.to(const CreateTemplateScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: CupertinoIcons.settings,
                  text: 'lorem',
                  onTap: () {
                    // Get.to(const SettingScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.logout,
                  text: 'Log Out',
                  color: errorColor,
                  onTap: () {
                    controller.logout();
                    Get.offAll(LoginScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap,
      Color? color,
      required BuildContext context}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? colorDark1,
        size: 24,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: color ?? primaryColor,
            fontSize: context.deviceHeight * .016,
            fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
