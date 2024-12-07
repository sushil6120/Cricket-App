import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/controllers/groundController.dart';
import 'package:you_got_world/controllers/matchController.dart';
import 'package:you_got_world/controllers/powerPlayController.dart';
import 'package:you_got_world/controllers/profileController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/shimmerContainer.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/bottomNavbar.dart';
import 'package:you_got_world/view/community/widget/globalAutocompleteWidget.dart';
import 'package:you_got_world/view/tossScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/startMatch/matchOfficialsScreen.dart';
import 'package:you_got_world/view/widget/startMatch/powerPlayView.dart';
import 'package:you_got_world/view/widget/startMatch/searchGroundScreen.dart';
import 'package:you_got_world/view/widget/textFormFields.dart';

class MatchScreen extends StatelessWidget {
  final MatchController controller = Get.put(MatchController());
  final ProfilController profilController = Get.put(ProfilController());
  GroundController groundControllers = Get.put(GroundController());
  final powerPlayController = Get.put(PowerPlayController());

  TextEditingController cityController = TextEditingController();
  TextEditingController noOfOverstroller = TextEditingController();
  TextEditingController noofBowelersOverstroller = TextEditingController();
  TextEditingController noofPairOverstroller = TextEditingController();
  TextEditingController maxBallController = TextEditingController();
  TextEditingController groundTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      appBar: AppBar(
        backgroundColor: colorLightWhite,
        surfaceTintColor: colorLightWhite,
        leading: IconButton(
            onPressed: () {
              Get.offAll(BottomNavBar(), transition: Transition.leftToRight);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          'SELECT TEAM A',
          style: TextStyle(
            fontSize: context.deviceHeight * .016,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: .5,
        shadowColor: colorDark3.withOpacity(.4),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Team Selection
                  Obx(
                    () {
                      if (controller.isLoading.value == true) {
                        return ShimmerTeamContainer();
                      } else {
                        return Container(
                          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: colorLight3)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTeamCard(
                                  controller
                                      .preStartMatchData.value.data!.teamA!.name
                                      .toString(),
                                  'SQUAD ${controller.preStartMatchData.value.data!.teamA!.totalSqad.toString()}',
                                  controller.preStartMatchData.value.data!
                                      .teamA!.teamProfile
                                      .toString(),
                                  context),
                              Text('VS',
                                  style: GoogleFonts.roadRage(
                                      fontSize: context.deviceHeight * .048,
                                      fontWeight: FontWeight.w400,
                                      color: errorColor)),
                              _buildTeamCard(
                                  controller
                                      .preStartMatchData.value.data!.teamB!.name
                                      .toString(),
                                  'SQUAD ${controller.preStartMatchData.value.data!.teamB!.totalSqad.toString()}',
                                  controller.preStartMatchData.value.data!
                                      .teamB!.teamProfile
                                      .toString(),
                                  context),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 10),

                  // Match Type Selection
                  _buildTitleText(
                      'Match Type', context.deviceWidth * .26, context),
                  SizedBox(height: 10),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.start,
                        children: controller.matchType.map((type) {
                          return ChoiceChip(
                            selectedColor: primaryColor,
                            showCheckmark: false,
                            backgroundColor: Colors.grey.shade200,
                            surfaceTintColor: colorLightWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.transparent)),
                            label: Text(
                              type.matchTypeName.toString(),
                              style: TextStyle(
                                color: controller.selectedMatchType.value ==
                                        type.matchTypeId
                                    ? colorLightWhite
                                    : colorDark1,
                                fontSize: context.deviceHeight * .014,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: controller.selectedMatchType.value ==
                                type.matchTypeId,
                            onSelected: (selected) {
                              if (selected) {
                                controller.selectMatchType(
                                    type.matchTypeId.toString(),
                                    type.matchTypeInput!.noOfOvers!.showInput
                                        .toString(),
                                    type.matchTypeInput!.overPerBowler!
                                        .showInput
                                        .toString(),
                                    type.matchTypeInput!.powerPlay!.showInput
                                        .toString(),
                                    type.matchTypeInput!.overPerPair!.showInput
                                        .toString(),
                                    type.matchTypeInput!.matchBall!.showInput
                                        .toString());

                                if (type.matchTypeInput!.matchBall!.showInput ==
                                    'YES') {
                                  maxBallController.text = type
                                      .matchTypeInput!.matchBall!.maxBall
                                      .toString();
                                  powerPlayController.limitTextInput(
                                      maxBallController,
                                      type.matchTypeInput!.matchBall!.maxBall!);
                                }
                              }
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),

                  SizedBox(height: 20),
                  // IconButton(
                  //     onPressed: () {
                  //       print(groundControllers.selectedGround.value);
                  //     },
                  //     icon: Icon(Icons.abc_outlined)),
                  // Input fields
                  Obx(() => Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          controller.selectedInputeType.value == "YES"
                              ? Expanded(
                                  child: _buildTextField(
                                      'No. of overs*', () {}, noOfOverstroller,
                                      (p0) {
                                  if (controller.showOverPerBowlerType.value ==
                                      "YES") {
                                    String text = noOfOverstroller.text;
                                    if (text.isNotEmpty) {
                                      int? totalOvers = int.tryParse(text);
                                      if (totalOvers != null) {
                                        int oversPerBowler =
                                            (totalOvers * 0.2).toInt();
                                        noofBowelersOverstroller.text =
                                            oversPerBowler.toString();
                                      } else {
                                        noofBowelersOverstroller.text = "0";
                                      }
                                    } else {
                                      noofBowelersOverstroller.text = "0";
                                    }
                                  }
                                }, context))
                              : SizedBox(),
                          controller.over_per_pair.value == "YES"
                              ? Expanded(
                                  child: _buildTextField(
                                      'Overs per Pair*',
                                      () {},
                                      noofPairOverstroller,
                                      (p0) {},
                                      context))
                              : SizedBox(),
                          controller.showOverPerBowlerType.value == "YES"
                              ? Expanded(
                                  child: _buildTextField(
                                      'Overs per Bowler*',
                                      () {},
                                      noofBowelersOverstroller,
                                      (p0) {},
                                      context))
                              : SizedBox(),
                          controller.match_ball.value == "YES"
                              ? Expanded(
                                  child: _buildTextField('max ball*', () {},
                                      maxBallController, (p0) {}, context))
                              : SizedBox(),
                          controller.power_play.value == "YES"
                              ? Expanded(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        int? overs =
                                            int.tryParse(noOfOverstroller.text);
                                        if (overs != null) {
                                          Get.to(PowerPlayView(
                                            controller: powerPlayController,
                                            overs: overs,
                                          ));
                                        }
                                      },
                                      label: Text(
                                        "Power Play",
                                        style: TextStyle(
                                            fontSize: 12, color: primaryColor),
                                      )),
                                )
                              : SizedBox.shrink()
                        ],
                      )),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 8, bottom: 8),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: groundTextController,
                        onTap: () {
                          _showGroundAlertDialog(groundControllers, context);
                        },
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: colorDark1,
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          labelText: 'Ground*',
                          labelStyle: TextStyle(
                              color: colorDark3,
                              fontSize: context.deviceHeight * .016,
                              fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: colorLight3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: colorLight3)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 8, bottom: 8),
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: cityController,
                        onTap: () {
                          _showAlertDialog(context);
                        },
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: colorDark1,
                              fontWeight: FontWeight.w400,
                            ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(6),
                          labelText: 'City / Town',
                          labelStyle: TextStyle(
                              color: colorDark3,
                              fontSize: context.deviceHeight * .016,
                              fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: colorLight3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(color: colorLight3)),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        bottom: verticalSpaceSmall2,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          controller.selectDate(context);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: context.deviceWidth,
                          height: context.deviceHeight * .06,
                          decoration: BoxDecoration(
                              color: colorLightWhite,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: colorLight3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 0),
                                  child: Text(
                                    controller.selectedDob.value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          controller.selectedDob.value != "DATE"
                                              ? colorDark1
                                              : colorDark3,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Ball Type Selection
                  _buildTitleText(
                      'Ball Type', context.deviceWidth * .2, context),
                  SizedBox(height: 14),
                  Obx(() {
                    return Center(
                      child: Container(
                          height: context.deviceHeight * .07,
                          width: context.deviceWidth,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: colorLight3,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: ListView.builder(
                              itemCount: controller.ballType.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var balls = controller.ballType[index];

                                return Obx(
                                  () {
                                    bool isSelected =
                                        controller.selectedBallType.value ==
                                            balls.ballId;
                                    return controller.ballType.isEmpty
                                        ? SizedBox.shrink()
                                        : Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.selectBallType(
                                                      balls.ballId.toString());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? primaryColor
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.network(
                                                        balls.ballImage
                                                            .toString(),
                                                        width: 40,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        balls.ballName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: context
                                                                    .deviceHeight *
                                                                .016,
                                                            color: isSelected
                                                                ? colorLightWhite
                                                                : colorDark1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                  },
                                );
                              },
                            ),
                          )),
                    );
                  }),
                  SizedBox(height: 20),
                  _buildTitleText(
                      'Wagon Wheel', context.deviceWidth * .3, context),
                  SizedBox(height: 10),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            controller.preStartMatchData.value.data!
                                .wagonWheelInputTitle
                                .toString(),
                            style: TextStyle(
                                fontSize: context.deviceHeight * .018,
                                color: colorDark3),
                          )),
                          Switch(
                            value: controller.wagonwheel.value,
                            activeColor: primaryColor,
                            onChanged: (value) {
                              controller.setWagonWheel(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Pitch Type Selection
                  _buildTitleText(
                      'Pitch Type', context.deviceWidth * .22, context),
                  SizedBox(height: 10),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Wrap(
                        spacing: 8.0, // Space between the chips horizontally
                        runSpacing: 8.0, // Space between the chips vertically
                        alignment: WrapAlignment
                            .start, // Align items to the start of the row
                        children: controller.pitchType.map((type) {
                          return ChoiceChip(
                            selectedColor: primaryColor,
                            showCheckmark: false,
                            backgroundColor: Colors.grey.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(color: Colors.transparent)),
                            label: Text(
                              type.pitchName.toString(),
                              style: TextStyle(
                                color: controller.selectedPitchType.value ==
                                        type.pitchId
                                    ? colorLightWhite
                                    : colorDark1,
                                fontSize: context.deviceHeight * .014,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: controller.selectedPitchType.value ==
                                type.pitchId,
                            onSelected: (selected) {
                              if (selected) {
                                controller
                                    .selectPitchType(type.pitchId.toString());
                              }
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  _buildTitleText(
                      'Match Officials', context.deviceWidth * .32, context),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMatchOfficials(
                              Icon(
                                Icons.person_4_sharp,
                                size: 26,
                                color: primaryColor,
                              ),
                              'Umpire', () {
                            Get.to(MatchOfficialsScreen(),
                                transition: Transition.rightToLeft);
                          }, context),
                          _buildMatchOfficials(
                              Icon(
                                Icons.scoreboard,
                                size: 26,
                                color: primaryColor,
                              ),
                              'Scorers', () {
                            Get.to(MatchOfficialsScreen(),
                                transition: Transition.rightToLeft);
                          }, context),
                          _buildMatchOfficials(
                              Icon(
                                Icons.live_tv_rounded,
                                size: 26,
                                color: primaryColor,
                              ),
                              'Live Streamer', () {
                            Get.to(MatchOfficialsScreen(),
                                transition: Transition.rightToLeft);
                          }, context),
                          _buildMatchOfficials(
                              Icon(
                                Icons.person_4_outlined,
                                size: 26,
                                color: primaryColor,
                              ),
                              'Other',
                              () {},
                              context),
                        ]),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RedButton(
                      onPressed: () {
                        Get.to(
                            TossScreen(
                              matchId: controller.matchId.value,
                            ),
                            transition: Transition.rightToLeft);
                      },
                      text: 'Next(Toss)'),
                ),
                SizedBox(
                  width: 10,
                ),
                Obx(
                  () => Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("matchId:" +
                            controller.matchId.value +
                            "ballType:" +
                            controller.selectedBallType.value +
                            "     matchType:" +
                            controller.selectedMatchType.value +
                            " cityTownId:" +
                            controller.selectedCityType.value +
                            "  groundId:" +
                            groundControllers.selectedGround.value +
                            "  pitchType:" +
                            controller.selectedPitchType.value +
                            "  matchDate: " +
                            controller.selectedDob.value +
                            "  matchTime:" '12:00 PM');
                        controller.scheduleMAtchApi(
                            wagonWheelActive:
                                controller.wagonwheel.value == true
                                    ? 'YES'
                                    : 'NO',
                            matchId: controller.matchId.value,
                            ballType: controller.selectedBallType.value,
                            matchType: controller.selectedMatchType.value,
                            cityTownId: controller.selectedCityType.value,
                            groundId: groundControllers.selectedGround.value,
                            pitchType: controller.selectedPitchType.value,
                            matchDate: controller.selectedDob.value,
                            powerPlayA: powerPlayController
                                .powerPlay1Overs.value
                                .toString(),
                            powerPlayB: powerPlayController
                                .powerPlay2Overs.value
                                .toString(),
                            powerPlayC: powerPlayController
                                .powerPlay3Overs.value
                                .toString(),
                            noOfOvers: noOfOverstroller.text,
                            overPerBaller: noofBowelersOverstroller.text,
                            overPerPair: noofPairOverstroller.text,
                            matchBall: maxBallController.text,
                            // wagonWheelActive:,
                            matchTime: '12:00 PM');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,

                        foregroundColor: Colors.white,
                        backgroundColor:
                            colorLightWhite, // Set the text color to white
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: primaryColor)),
                      ),
                      child: controller.isScheduleLoad.value == true
                          ? LoadingWidget()
                          : Text(
                              'Schedule Match',
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildMatchOfficials(
      Icon icon, title, VoidCallback onTap, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: colorLight1,
                shape: BoxShape.circle,
                border: Border.all(color: colorLight3)),
            child: Center(child: icon),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: context.deviceHeight * .016, color: colorDark3),
          )
        ],
      ),
    );
  }

  Widget _buildTitleText(String title, double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: context.deviceHeight * .019,
                fontWeight: FontWeight.w600,
              )),
          Container(
            width: width,
            height: 2,
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          )
        ],
      ),
    );
  }

  Widget _buildTeamCard(
      String team, String squad, String imagePath, BuildContext context) {
    print(imagePath);
    return Column(
      children: [
        CircleAvatar(
            radius: 30,
            backgroundColor: colorLight2,
            child: imagePath == null || imagePath.isEmpty
                ? Text(team[0] + team[1])
                : Image.network(
                    imagePath,
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.flag_circle,
                        size: 60,
                        color: primaryColor,
                      );
                    },
                  )),
        SizedBox(height: 4),
        Text(team,
            style: TextStyle(
                fontSize: context.deviceHeight * .024,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        Container(
            padding: EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 6),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(38)),
            child: Text(squad,
                style: TextStyle(
                    fontSize: context.deviceHeight * .012,
                    color: colorLightWhite,
                    fontWeight: FontWeight.w500))),
      ],
    );
  }

  Widget _buildTextField(
      String label,
      VoidCallback onTap,
      TextEditingController? controller,
      Function(String)? onChanged,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 10, top: 8, bottom: 8),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [LengthLimitingTextInputFormatter(3)],
          controller: controller,
          onTap: onTap,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: colorDark1,
                fontWeight: FontWeight.w400,
              ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(6),
            labelText: label,
            labelStyle: TextStyle(
                color: colorDark3,
                fontSize: context.deviceHeight * .012,
                fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: colorLight3)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: colorLight3)),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: context.deviceHeight * .48,
            width: context.deviceWidth * .95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      bottom: verticalSpaceSmall2,
                      top: 10),
                  child: TextFormFieldBig(
                    height: 50,
                    hintText: 'Search location..',
                    maxLines: 1,
                    enabled: true,
                    fillColor: colorLight2,
                    isFill: true,
                    onChanged: (p0) {
                      Timer(const Duration(milliseconds: 500), () {
                        profilController.locationLocalAreaData.clear();
                        profilController.locationLocalAreaApis(p0);
                      });
                    },
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          if (profilController.locationLoad.value == true) {
                            return LoadingWidget();
                          } else if (profilController
                              .locationLocalAreaData.isEmpty) {
                            return Center(
                              heightFactor: 6,
                              child: Text(
                                "Search your location,\nex:- Pincode,Name etc.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorDark3,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount:
                                  profilController.locationLocalAreaData.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    controller.selectedCityType.value =
                                        profilController
                                            .locationLocalAreaData[index]
                                            .locationId
                                            .toString();
                                    cityController.text = profilController
                                        .locationLocalAreaData[index].location
                                        .toString();

                                    Navigator.pop(context);
                                  },
                                  title: Text(
                                    profilController
                                        .locationLocalAreaData[index].location
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  //

  void _showGroundAlertDialog(
      GroundController controller, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Ground',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: context.deviceHeight * .48,
            width: context.deviceWidth * .95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                      bottom: verticalSpaceSmall2,
                      top: 10),
                  child: TextFormFieldBig(
                    height: 50,
                    hintText: 'Search Ground..',
                    maxLines: 1,
                    enabled: true,
                    fillColor: colorLight2,
                    isFill: true,
                    onChanged: (p0) {
                      Timer(const Duration(milliseconds: 800), () {
                        controller.searchGroundApi(p0);
                      });
                    },
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () {
                          if (controller.isLoading.value == true) {
                            return LoadingWidget();
                          } else if (controller.searchGroundData.isEmpty) {
                            return Center(
                              heightFactor: 6,
                              child: Text(
                                "Search your Ground",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorDark3,
                                    fontWeight: FontWeight.w400),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: controller.searchGroundData.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    controller.selectedGround.value = controller
                                        .searchGroundData[index].groundId
                                        .toString();
                                    print(
                                        "GROUND ID : ${controller.selectedGround.value}");
                                    groundTextController.text = controller
                                        .searchGroundData[index].groundName
                                        .toString();

                                    Navigator.pop(context);
                                  },
                                  title: Text(
                                    controller
                                        .searchGroundData[index].groundName
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
