import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/controllers/tabController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/bottomNavbar.dart';
import 'package:you_got_world/view/matchScreen.dart';
import 'package:you_got_world/view/teamSelectionScreen.dart';
import 'package:you_got_world/view/widget/redButton.dart';

class SelectTeamsScreens extends StatelessWidget {
  String? teamLogo, title, numberofSquad;
  String? oppteamLogo, opptitle, oppnumberofSquad;
  SelectTeamsScreens({
    super.key,
    this.numberofSquad,
    this.teamLogo,
    this.title,
    this.oppnumberofSquad,
    this.oppteamLogo,
    this.opptitle,
  });

  @override
  Widget build(BuildContext context) {
    final _tabController = Get.put(TabSwitchController());

    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: colorLightWhite,
        surfaceTintColor: colorLightWhite,
        shadowColor: colorLight3,
        elevation: .5,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(BottomNavBar(), transition: Transition.leftToRight);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Select playing teams",
          style: TextStyle(
            fontSize: context.deviceHeight * .020,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: context.deviceHeight * .1,
          ),
          customTeamButton(title == null ? "Select Team A" : "squad ${title!}",
              teamLogo, numberofSquad, () {
            Get.to(
                TeamSelectionScreen(
                  screenName: '',
                  title: "Select Team A",
                ),
                transition: Transition.rightToLeft);
          }, context),
          SizedBox(
            height: context.deviceHeight * .1,
          ),
          Center(
            child: Text(
              'VS',
              style: GoogleFonts.roadRage(
                  fontSize: context.deviceHeight * .048,
                  fontWeight: FontWeight.w400,
                  color: errorColor),
            ),
          ),
          SizedBox(
            height: context.deviceHeight * .1,
          ),
          Obx(
            () {
              return _tabController.currentIndex == 10
                  ? SizedBox()
                  : customTeamButton(
                      opptitle == null ? "Select Team B" : "squad ${opptitle!}",
                      oppteamLogo,
                      numberofSquad, () {
                      
                      Get.to(
                          TeamSelectionScreen(
                            screenName: 'opponent',
                            title: "Select Team B",
                          ),
                          transition: Transition.rightToLeft);
                    }, context);
                    //   Get.to(
                    //       MatchScreen(),
                    //       transition: Transition.rightToLeft);
                    // }, context);
            },
          )
        ],
      ),
    );
  }

  Widget customTeamButton(String title, teamLogo, numberofSquad,
      VoidCallback onTap, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            teamLogo == null
                ? CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.add,
                      color: colorLightWhite,
                      size: 50,
                    ),
                  )
                : CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor,
                    backgroundImage: NetworkImage(teamLogo),
                  ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: context.deviceWidth * .35,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(44)),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: context.deviceHeight * .015,
                      fontWeight: FontWeight.w500,
                      color: colorLightWhite),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customOpponentTeamButton(String title, teamLogo, numberofSquad,
      VoidCallback onTap, BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            teamLogo == null
                ? CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.add,
                      color: colorLightWhite,
                      size: 50,
                    ),
                  )
                : CircleAvatar(
                    radius: 45,
                    backgroundColor: primaryColor,
                    backgroundImage: NetworkImage(teamLogo),
                  ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: context.deviceWidth * .35,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(44)),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: context.deviceHeight * .015,
                      fontWeight: FontWeight.w500,
                      color: colorLightWhite),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
