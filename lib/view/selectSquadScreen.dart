import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/addPlayerScreen.dart';
import 'package:you_got_world/view/assignSquadScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/redButton.dart';
import '../controllers/squadController.dart';
import '../themes/colors.dart';
import 'widget/startMatch/selectTeamWidget/squadCardWidget.dart';

class SelectSquadScreen extends StatefulWidget {
  String title, teamId, teamLogo;
  String? screen;
  SelectSquadScreen(
      {super.key,
      required this.title,
      required this.teamId,
      this.screen,
      required this.teamLogo});

  @override
  State<SelectSquadScreen> createState() => _SelectSquadScreenState();
}

class _SelectSquadScreenState extends State<SelectSquadScreen> {
  final SquadController squadController = Get.put(SquadController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    squadController.teamPlayerListApi(widget.teamId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: colorLightWhite),
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: context.deviceHeight * .018,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(
        () {
          if (squadController.isDataLoad.value == true) {
            return LoadingWidget();
          } else {
            return Column(
              children: [
                // Container(
                //   height: context.deviceHeight * .24,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage(widget
                //           .teamLogo), // Replace with your background image URL
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   child: Container(
                //     decoration:
                //         BoxDecoration(color: primaryColor.withOpacity(.8)),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select squad',
                            style: TextStyle(
                              fontSize: context.deviceHeight * .017,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            ' (optional)',
                            style: TextStyle(
                              fontSize: context.deviceHeight * .017,
                              fontWeight: FontWeight.w400,
                              color: colorDark3,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          bool allSelected = squadController.areAllSelected();
                          squadController.selectAll(!allSelected);
                        },
                        child: Text(
                          'SELECT ALL',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: context.deviceHeight * .017,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            border: Border.all(color: colorLight3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              suffix: Icon(
                                CupertinoIcons.search,
                                color: colorDark3,
                                size: 20,
                              ),
                              hintText: 'Quick search',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: colorDark3,
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                              AddPlayerScreen(
                                teamName: widget.title,
                                screen: widget.screen,
                                teamid: widget.teamId,
                              ),
                              transition: Transition.rightToLeft);
                        },
                        child: Text(
                          'Add Player',
                          style: TextStyle(
                              fontSize: 12,
                              color: colorLightWhite,
                              fontWeight: FontWeight.w500),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.all(14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: verticalSpaceSmall2,
                ),
                squadController.playerListData.isEmpty
                    ? Center(
                        child: Text("No Data Found !"),
                      )
                    : Expanded(
                        child: Obx(() {
                          return RefreshIndicator(
                            onRefresh: () async {
                              squadController.teamPlayerListApi(widget.teamId);
                            },
                            child: ListView.builder(
                              padding: EdgeInsets.zero, // Remove extra padding
                              itemCount: squadController.playerListData.length,
                              itemBuilder: (context, index) {
                                var item =
                                    squadController.playerListData[index];
                                return SquadCard(
                                    id: item.playerId.toString(),
                                    image: item.playerProfile.toString(),
                                    name: item.playerName.toString(),
                                    index: index);
                              },
                            ),
                          );
                        }),
                      ),

                Obx(
                  () {
                    return squadController.selectedPlayerIds.value.isEmpty
                        ? SizedBox.shrink()
                        : SizedBox(
                            width: context.width * .95,
                            child: RedButton(
                                onPressed: () {
                                  Get.to(
                                      AssignSquadScreen(
                                        screen: widget.screen.toString(),
                                        squadLength: squadController
                                            .selectedPlayerIds.length
                                            .toString(),
                                        selectedPlayerIds: squadController
                                            .selectedPlayerIds.value,
                                        teamId: widget.teamId,
                                        image: widget.teamLogo,
                                        title: widget.title,
                                        item: squadController
                                            .playerListData.value,
                                      ),
                                      transition: Transition.rightToLeft);
                                },
                                text: "Next"),
                          );
                  },
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
