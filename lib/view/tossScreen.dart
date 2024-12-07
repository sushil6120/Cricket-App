import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/scoringScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import '../controllers/tossController.dart';
import 'widget/redButton.dart';

class TossScreen extends StatefulWidget {
  String matchId;
  TossScreen({super.key, required this.matchId});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  final TossController tossController = Get.put(TossController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tossController.teamDetailsApi(widget.matchId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorLightWhite,
        appBar: AppBar(
          elevation: .2,
          shadowColor: colorDark3,
          title: Text(
            'Toss',
            style: TextStyle(
              fontSize: context.deviceHeight * .020,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: colorLightWhite,
          surfaceTintColor: colorLightWhite,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back navigation
              Get.back();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                // Handle camera action
              },
            ),
          ],
        ),
        body: Obx(
          () {
            if (tossController.isLoading.value == true) {
              return LoadingWidget();
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: verticalSpaceMedium),
                          _buildTitleText('Who won the toss?',
                              context.deviceWidth * .42, context),
                          SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildTeamSelection(
                                    tossController
                                        .teaDetailsData.value.data!.teamAName
                                        .toString(),
                                    tossController
                                        .teaDetailsData.value.data!.teamAId
                                        .toString(),
                                    tossController
                                        .teaDetailsData.value.data!.teamAProfile
                                        .toString(),
                                    tossController,
                                    context),
                                buildTeamSelection(
                                    tossController
                                        .teaDetailsData.value.data!.teamBName
                                        .toString(),
                                    tossController
                                        .teaDetailsData.value.data!.teamBId
                                        .toString(),
                                    tossController
                                        .teaDetailsData.value.data!.teamBProfile
                                        .toString(),
                                    tossController,
                                    context),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTitleText('Winner of the toss elected to?',
                              context.deviceWidth * .65, context),
                          SizedBox(height: 14),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildOptionSelection(
                                    'BAT', Icons.sports_cricket, context),
                                buildOptionSelection(
                                    'BOWL', Icons.sports_baseball, context),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTitleText('Tap the coin to filp',
                              context.deviceWidth * .4, context),
                          SizedBox(height: 14),
                          Obx(() => Center(
                                heightFactor: 1.2,
                                child: GestureDetector(
                                  onTap: () {
                                    if (!tossController.isCoinFlipped.value) {
                                      tossController.flipCoin();
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: primaryColor,
                                    child: tossController.isCoinFlipped.value
                                        ? Text(
                                            tossController.flipResult.value,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        : Icon(Icons.account_circle,
                                            color: Colors.white, size: 70),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => SizedBox(
                          width: context.deviceWidth * .9,
                          child: tossController.isDataLoad.value == true
                              ? LoadingWidget()
                              : RedButton(
                                  onPressed: () {
                                    if (tossController
                                        .selectedTeam.value.isEmpty) {
                                      showSnackbar('Select team',
                                          'Please select a team that won the toss.');
                                      return;
                                    }

                                    if (tossController
                                        .flipResult.value.isEmpty) {
                                      showSnackbar('Flip Result',
                                          'Please select the flip result (HEAD or TAIL).');
                                      return;
                                    }

                                    if (tossController.selectedOption.isEmpty) {
                                      showSnackbar('Select either BAT or BOWL',
                                          'Please select either BAT or BOWL.');
                                      return;
                                    }
                                    String tossLooserTeamId =
                                        tossController.selectedTeam ==
                                                tossController.teaDetailsData
                                                    .value.data!.teamAId
                                                    .toString()
                                            ? tossController.teaDetailsData
                                                .value.data!.teamBId
                                                .toString()
                                            : tossController.teaDetailsData
                                                .value.data!.teamAId
                                                .toString();

                                    String tossBiddByTeamA = tossController
                                                .teaDetailsData
                                                .value
                                                .data!
                                                .teamAId ==
                                            tossController.selectedTeam.value
                                        ? tossController.flipResult.value
                                        : (tossController.flipResult.value ==
                                                'HEAD'
                                            ? 'TAIL'
                                            : 'HEAD');
                                    String tossBiddByTeamB = tossController
                                                .teaDetailsData
                                                .value
                                                .data!
                                                .teamBId ==
                                            tossController.selectedTeam.value
                                        ? tossController.flipResult.value
                                        : (tossController.flipResult.value ==
                                                'HEAD'
                                            ? 'TAIL'
                                            : 'HEAD');
                                    tossController.tossMathcApi(
                                        widget.matchId,
                                        tossController.flipResult.value,
                                        tossController.selectedTeam.value,
                                        tossBiddByTeamA,
                                        tossBiddByTeamB,
                                        tossController.selectedOption == 'BAT'
                                            ? tossController.selectedTeam.value
                                            : (tossController
                                                        .selectedTeam.value ==
                                                    tossController.teaDetailsData
                                                        .value.data!.teamAId
                                                ? tossController.teaDetailsData
                                                    .value.data!.teamAId
                                                : tossController.teaDetailsData
                                                    .value.data!.teamBId),
                                        tossController.selectedOption == 'BAT'
                                            ? tossController.selectedTeam.value
                                            : (tossController
                                                        .selectedTeam.value ==
                                                    tossController
                                                        .teaDetailsData
                                                        .value
                                                        .data!
                                                        .teamBId
                                                ? tossController.teaDetailsData
                                                    .value.data!.teamBId
                                                : tossController.teaDetailsData
                                                    .value.data!.teamAId),
                                        tossLooserTeamId);
                                  },
                                  text: 'Let’s Play'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: context.deviceWidth * .9,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,

                            foregroundColor: Colors.white,
                            backgroundColor:
                                colorLightWhite, // Set the text color to white
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(color: primaryColor)),
                          ),
                          child: Text(
                            'Need Help?',
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            }
          },
        ));
  }

  Widget buildTeamSelection(String team, teamId, String image,
      TossController controller, BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          tossController.selectTeam(teamId);
        },
        child: Container(
          padding: EdgeInsets.only(
              left: context.deviceWidth * .08,
              right: context.deviceWidth * .08,
              top: 24,
              bottom: 24),
          decoration: BoxDecoration(
            color: tossController.selectedTeam.value == teamId
                ? primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: tossController.selectedTeam.value == teamId
                    ? primaryColor
                    : Colors.blueGrey),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  image,
                ),
              ),
              SizedBox(height: 4),
              Text(
                team,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    color: tossController.selectedTeam.value == teamId
                        ? colorLightWhite
                        : colorDark2),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTitleText(String title, double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: context.deviceHeight * .019,
                fontWeight: FontWeight.w600,
              )),
          Container(
            width: width,
            height: 3,
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

  Widget buildOptionSelection(
      String option, IconData icon, BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          tossController.selectOption(option);
        },
        child: Container(
          padding: EdgeInsets.only(
              left: context.deviceWidth * .115,
              right: context.deviceWidth * .115,
              top: 22,
              bottom: 22),
          decoration: BoxDecoration(
            color: tossController.selectedOption.value == option
                ? primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blueGrey),
          ),
          child: Column(
            children: [
              CircleAvatar(
                  backgroundColor: tossController.selectedOption.value == option
                      ? colorLightWhite
                      : primaryColor,
                  radius: 32,
                  child: Icon(
                    icon,
                    size: 30,
                    color: tossController.selectedOption.value == option
                        ? primaryColor
                        : colorLightWhite,
                  )),
              SizedBox(height: 8),
              Text(option,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: tossController.selectedOption.value == option
                          ? colorLightWhite
                          : primaryColor)),
            ],
          ),
        ),
      );
    });
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
