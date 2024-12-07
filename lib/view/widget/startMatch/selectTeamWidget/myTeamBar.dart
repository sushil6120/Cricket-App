import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/controllers/startMatchController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/selectSquadScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/serchBarWidget.dart';

import 'teamCardWidget.dart';

class MyTeamTab extends StatelessWidget {
  StartMatchController startMatchController = Get.put(StartMatchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorLightWhite,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () {
              if (startMatchController.isDataLoad.value == true) {
                return LoadingWidget();
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchBarWidget(
                            screen: 'MyTeamTab',
                          ),
                          SizedBox(height: 10),
                          startMatchController.myTeamListData.isEmpty
                              ? Center(
                                  child: Text("No Data Found !"),
                                )
                              : Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      await startMatchController
                                          .myTeamListApi();
                                    },
                                    child: ListView.builder(
                                      itemCount: startMatchController
                                          .myTeamListData
                                          .length, // Number of teams
                                      itemBuilder: (context, index) {
                                        var item = startMatchController
                                            .myTeamListData[index];
                                        return Obx(
                                          () {
                                            return TeamCardWidget(
                                              index: index,
                                              myteamIndex: startMatchController
                                                          .myTeamIndex.value ==
                                                      null
                                                  ? -1
                                                  : startMatchController
                                                      .myTeamIndex.value!,
                                              isSelected: false,
                                              isOpponent: false,
                                              teamName:
                                                  item.teamName.toString(),
                                              location:
                                                  item.teamCity.toString(),
                                              imageUrl:
                                                  item.teamProfile.toString(),
                                              onTap: () {
                                                startMatchController
                                                    .setMyTeamIndex(index);
                                                startMatchController
                                                    .setMyTeamData(
                                                        item.teamId.toString(),
                                                        item.teamProfile
                                                            .toString(),
                                                        item.teamName
                                                            .toString());
                                                // Get.to(
                                                //     SelectSquadScreen(
                                                //       teamLogo: item.teamProfile.toString(),
                                                //       teamId: item.teamId.toString(),
                                                //       title: item.teamName.toString(),
                                                //     ),
                                                //     transition: Transition.rightToLeft);
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        return startMatchController.myTeamIndex.value == null
                            ? SizedBox.shrink()
                            : SizedBox(
                              width: context.deviceWidth*.95,
                              child: RedButton(
                                  onPressed: () {
                                    Get.to(
                                        SelectSquadScreen(
                                          teamLogo: startMatchController
                                              .teamLogo.value
                                              .toString(),
                                          teamId: startMatchController
                                              .teamId.value
                                              .toString(),
                                          title: startMatchController
                                              .teamNameValue
                                              .toString(),
                                        ),
                                        transition: Transition.rightToLeft);
                                  },
                                  text: 'Done'),
                            );
                      },
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
