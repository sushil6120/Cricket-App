import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_got_world/services/sharedPrefs.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/utils/utilsFunction.dart';
import 'package:you_got_world/utils/valueConstants.dart';
import 'package:you_got_world/view/bottomNavbar.dart';
import 'package:you_got_world/view/matchScreen.dart';
import 'package:you_got_world/view/selectTeamsScreens.dart';
import '../controllers/squadController.dart';
import '../model/teamPlayerModel.dart';
import '../themes/colors.dart';
import 'widget/startMatch/selectTeamWidget/selectCaptainCard.dart';
import 'widget/redButton.dart';

class AssignSquadScreen extends StatelessWidget {
  final String title, image, teamId, squadLength;
  final List<PlayerList> item;
  String? screen;
  List<String> selectedPlayerIds;

  AssignSquadScreen({
    super.key,
    required this.image,
    required this.title,
    required this.item,
    required this.teamId,
    required this.selectedPlayerIds,
    required this.squadLength,
    this.screen,
  });

  final SquadController squadController = Get.put(SquadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Get.offAll(BottomNavBar(), transition: Transition.leftToRight);
        //     },
        //     icon: Icon(Icons.arrow_back)),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: colorLightWhite),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: context.deviceHeight * .018,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   height: context.deviceHeight * .24,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage(image),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   child: Container(
          //     decoration: BoxDecoration(color: primaryColor.withOpacity(.8)),
          //   ),
          // ),
          SizedBox(
            height: verticalSpaceSmall,
          ),
          Obx(() {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: squadController.positions.map((position) {
                  final isSelected =
                      squadController.selectedPosition.value == position;
                  return GestureDetector(
                    onTap: () {
                      squadController.selectedPosition.value = position;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryColor.withOpacity(.3)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : colorDark3,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          position,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : colorDark3,
                            fontSize: context.deviceHeight * .015,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
          SizedBox(
            height: verticalSpaceSmall2,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero, // Set padding to zero
              shrinkWrap: true,
              itemCount: item.length,
              itemBuilder: (context, index) {
                final player = item[index];
                if (selectedPlayerIds.contains(item[index].playerId)) {
                  return SelectCaptainCardWidget(
                    playerId: player.playerId.toString(),
                    image: player.playerProfile ?? '',
                    name: player.playerName ?? '',
                    index: index,
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),

          Obx(
            () {
              return squadController.selectedCaptainId.value.isEmpty &&
                          squadController
                              .selectedWicketKeeperId.value.isEmpty ||
                      squadController.selectedCaptainId.value == '' &&
                          squadController.selectedWicketKeeperId.value == ''
                  ? SizedBox.shrink()
                  : SizedBox(
                      width: context.deviceWidth * .95,
                      child: RedButton(
                        isLoading: squadController.isDataLoad.value,
                        onPressed: () {
                          if (squadController.selectedCaptainId.value.isEmpty &&
                              squadController
                                  .selectedWicketKeeperId.value.isEmpty) {
                            Utils.toastMessage(
                                'Please select captain and wicketkeeper!');
                          } else {
                            squadController
                                .addCaptainWiketApi(
                                    teamId,
                                    squadController.selectedCaptainId.value,
                                    squadController
                                        .selectedWicketKeeperId.value,
                                    screen,
                                    squadLength,
                                    image)
                                .then((value) async {});
                          }
                        },
                        text: "Next",
                      ),
                    );
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
