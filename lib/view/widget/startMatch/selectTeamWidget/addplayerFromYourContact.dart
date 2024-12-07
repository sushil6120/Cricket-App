import 'package:flutter/material.dart';
import 'package:you_got_world/controllers/squadController.dart';
import 'package:you_got_world/themes/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:you_got_world/utils/responsive.dart';
import 'package:you_got_world/view/addTeamScreen.dart';
import 'package:you_got_world/view/widget/loadingWidget.dart';
import 'package:you_got_world/view/widget/startMatch/selectTeamWidget/addPlayerByNamePhone.dart';

class AddPlayersFromYourContact extends StatefulWidget {
  String teamid;
  String teamName;
  String? screen;
  AddPlayersFromYourContact(
      {super.key, required this.teamid, required this.teamName, this.screen});

  @override
  State<AddPlayersFromYourContact> createState() =>
      _AddPlayersFromYourContactState();
}

class _AddPlayersFromYourContactState extends State<AddPlayersFromYourContact> {
  SquadController squadController = Get.put(SquadController());

  @override
  void initState() {
    super.initState();
    squadController.selectContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorLightWhite,
        appBar: AppBar(
          centerTitle: true,
          elevation: .5,
          shadowColor: colorLight2,
          backgroundColor: colorLightWhite,
          surfaceTintColor: colorLightWhite,
          title: Text(
            'Add Player From Your Contact',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        body: Obx(
          () {
            return squadController.contactList.isEmpty
                ? Center(
                    child:
                        LoadingWidget()) // Show loading indicator while fetching
                : Stack(
                    children: [
                      ListView.builder(
                        itemCount: squadController.contactList.length,
                        itemBuilder: (context, index) {
                          final contact = squadController.contactList[index];
                          return ListTile(
                            title: Text(contact.displayName ?? "No Name"),
                            subtitle: contact.phones!.isNotEmpty
                                ? Text(contact.phones!.first.number ??
                                    "No Phone Number")
                                : null,
                            onTap: () {
                              // Handle contact tap (e.g., add to your team)
                              String? phoneNumber = contact.phones!.isNotEmpty
                                  ? formatPhoneNumber(
                                      contact.phones!.first.number.toString())
                                  : null;
                              String? name = contact.displayName;

                              if (name == null || name.isEmpty) {
                                Get.snackbar("Add Contact",
                                    "Contact has no name, only number: $phoneNumber");
                              } else if (name == null || name.isEmpty) {
                                Get.to(
                                    AddPlayerByNamePhoneScreen(
                                      teamName: widget.teamName,
                                      teamId: widget.teamid,
                                      screen: widget.screen,
                                    ),
                                    transition: Transition.rightToLeft);
                              } else {
                                print("${phoneNumber}  $name");
                                squadController.addPlayerApi(
                                    widget.teamid, phoneNumber, name);
                              }
                            },
                          );
                        },
                      ),
                      squadController.isDataLoad.value == true
                          ? Container(
                              width: context.deviceWidth,
                              height: context.deviceHeight,
                              decoration: BoxDecoration(
                                color: colorDark1.withOpacity(.1),
                              ),
                              child: LoadingWidget(),
                            )
                          : SizedBox.shrink()
                    ],
                  );
          },
        ));
  }

  String formatPhoneNumber(String phoneNumber) {
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanedNumber.startsWith('91')) {
      cleanedNumber = cleanedNumber.substring(2);
    }

    if (cleanedNumber.startsWith('0')) {
      cleanedNumber = cleanedNumber.substring(1);
    }

    if (cleanedNumber.length == 10) {
      return cleanedNumber;
    } else {
      throw Exception("Invalid phone number length: $cleanedNumber");
    }
  }
}
