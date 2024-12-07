import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/tabController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/matchScreen.dart';
import 'package:you_got_world/view/scoringScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/opponentsEmptyWidget.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/serchBarWidget.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/teamCardWidget.dart';

import '../../../../controllers/opponentController.dart';
import '../../../../controllers/squadController.dart';
import '../../../selectSquadScreen.dart';

class OpponentsScreen extends StatelessWidget {
  final SquadController controller =
      Get.put(SquadController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    final OpponentController opponentController = Get.put(OpponentController());

    return Scaffold(
      backgroundColor: colorLightWhite,
      body: Obx(
        () {
          if (opponentController.isLoading.value == true) {
            return LoadingWidget();
          } else {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchBarWidget(
                          screen: 'OpponentsScreen',
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Obx(() {
                            if (opponentController.opponentTeamData.isEmpty) {
                              return OpponentsEmptyWidget();
                            } else {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  await opponentController.opponentTeamListApi();
                                },
                                child: ListView.builder(
                                  itemCount: opponentController.opponentTeamData
                                      .length, // For testing, you can increase this
                                  itemBuilder: (context, index) {
                                    var item =
                                        opponentController.opponentTeamData[index];
                                    bool isSelected =
                                        controller.selectedTeamIndex.value == index;
                                    print(
                                        'Building TeamCard for index $index, isSelected: $isSelected'); // Debugging log
                  
                                    return Obx(
                                      () {
                                        return TeamCardWidget(
                                          index: index,
                                          myteamIndex: opponentController
                                                      .myTeamIndex.value ==
                                                  null
                                              ? -1
                                              : opponentController.myTeamIndex.value!,
                                          isOpponent: true,
                                          teamName: item.teamName.toString(),
                                          location: item.teamCity.toString(),
                                          imageUrl: item.teamProfile.toString(),
                                          onTap: () {
                                            print('Team at index $index tapped');
                                            opponentController.setMyTeamIndex(index);
                                            opponentController.setMyTeamData(
                                                item.teamId.toString(),
                                                item.teamProfile.toString(),
                                                item.teamName.toString());
                                            // Get.to(
                                            //     SelectSquadScreen(
                                            //       screen: 'OpponentsScreen',
                                            //       teamLogo: item.teamProfile.toString(),
                                            //       teamId: item.teamId.toString(),
                                            //       title: item.teamName.toString(),
                                            //     ),
                                            //     transition: Transition.rightToLeft);
                                          },
                                          isSelected: isSelected,
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
        () {
          return opponentController.myTeamIndex.value == null
                  ? SizedBox.shrink()
                  : SizedBox(
                    width: context.deviceWidth*.95,
                    child: RedButton(
                                onPressed: () {
                                  Get.to(
                                      SelectSquadScreen(
                                        screen: 'OpponentsScreen',
                                        teamLogo:
                                            opponentController.teamLogo.value.toString(),
                                        teamId:
                                            opponentController.teamId.value.toString(),
                                        title:
                                            opponentController.teamNameValue.toString(),
                                      ),
                                      transition: Transition.rightToLeft);
                                  // Get.to(ScoringScreen());
                                },
                                text: 'Done'),
                  );
        },
      )
              ],
            );
          }
        },
      ),

     

      // ),
    );
  }
}
