import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:you_got_world/model/temMatchModel.dart';
import 'package:you_got_world/utils/utilsFunction.dart';
import 'package:you_got_world/view/matchScreen.dart';
import 'package:you_got_world/view/selectTeamsScreens.dart';

import '../model/teamPlayerModel.dart';
import '../repo/startMatchRepo.dart';
import '../services/sharedPrefs.dart';

class SquadController extends GetxController {
  StartMatchRepo startMatchRepo = StartMatchRepo();

  var members = List.generate(4, (index) => Member('', false)).obs;
  var keyMembers = List.generate(4, (index) => Member('', false)).obs;
  var selectedTeamIndex = (-1).obs;
  var indexs = 10.obs;
  var loding = false.obs;
  var isDataLoad = false.obs;
  var selectedCaptainId = ''.obs;
  var selectedWicketKeeperId = ''.obs;
  RxList<Contact> contactList = <Contact>[].obs;

  RxList<PlayerList> playerListData = <PlayerList>[].obs;
  RxList<String> selectedPlayerIds = <String>[].obs;
  RxList<String> keySelectedPlayerIds = <String>[].obs;
  RxMap<String, String> assignedPositions = <String, String>{}.obs;

  var selectedPosition = 'Captain'.obs;
  var positions = ['Captain', 'Wicket Keeper', '12th Man'].obs;

  // ------ Contact Code ----

  void selectContact() async {
    // Request permissions
    var status = await Permission.contacts.status;

    if (status.isDenied) {
      await Permission.contacts.request();
      status = await Permission.contacts.status;
    }

    if (status.isGranted) {
      try {
        // Retrieve contacts
        Iterable<Contact> contacts = await FastContacts.getAllContacts();
        List<Contact> _contactList = contacts.toList(); // Get the contacts

        if (_contactList.isEmpty) {
          Get.snackbar("No Contacts", "No contacts found on the device.");
          return;
        }

        contactList.clear();
        contactList.addAll(_contactList);
      } catch (e) {
        Get.snackbar("Error", "Failed to load contacts: $e");
      }
    } else {
      Get.snackbar("Permission Denied",
          "Please allow contact access to use this feature.");
    }
  }

  // -----

  void setPosition(String value) {
    selectedPosition.value = value;
  }

  void assignPosition(String playerId, String position) {
    if (assignedPositions.containsKey(position)) {
      assignedPositions.remove(position);
    }
    assignedPositions[position] = playerId;
  }

  void togglePlayerSelection(int index, String playerId) {
    if (selectedPosition.value == 'Captain') {
      if (selectedCaptainId.value == playerId) {
      } else {
        selectedCaptainId.value = playerId; // Assign Captain
      }
    } else if (selectedPosition.value == 'Wicket Keeper') {
      if (selectedWicketKeeperId.value == playerId) {
      } else {
        selectedWicketKeeperId.value = playerId;
      }
    }

    print('Assigned Positions Captain : ${selectedCaptainId.value}');
    print('Assigned Positions Wicket Keeper: ${selectedWicketKeeperId.value}');
  }

  void toggleSelection(int index) {
    members[index].isSelected.value = !members[index].isSelected.value;

    if (members[index].isSelected.value) {
      selectedPlayerIds.add(playerListData[index].playerId.toString());
    } else {
      selectedPlayerIds.remove(playerListData[index].playerId);
    }
    print('Selected player IDs: $selectedPlayerIds');
  }

  void toggleOpponentSelection(int index) {
    keyMembers[index].isSelected.value = !keyMembers[index].isSelected.value;

    if (keyMembers[index].isSelected.value) {
      keySelectedPlayerIds.add(playerListData[index].playerId.toString());
    } else {
      keySelectedPlayerIds.remove(playerListData[index].playerId);
    }
    print('Key Selected player IDs: $selectedPlayerIds');
  }

  bool areAllSelected() {
    return members.every((member) => member.isSelected.value);
  }

  void selectAll(bool isSelected) {
    for (var member in members) {
      member.isSelected.value = isSelected;
    }
    if (isSelected) {
      selectedPlayerIds.value =
          playerListData.map((player) => player.playerId.toString()).toList();
    } else {
      selectedPlayerIds.clear();
    }
    print("All Player Id : ${selectedPlayerIds.value}");
  }

  void selectTeam(int index) {
    selectedTeamIndex.value = index;
    print('Selected team index updated to $index');
  }

  // ----- Api -----

  Future<void> teamPlayerListApi(String teamId) async {
    final controller = await Get.put(SharedPreferencesController());
    playerListData.clear();
    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();

      var response = await startMatchRepo.teamPlayerListApi(token!, teamId);
      playerListData.value.addAll(response.data!.playerList!.toList());
      isDataLoad.value = false;
    } catch (e) {
      isDataLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // ---

  void shareLink() {
    // Add code to share the link
    print("Share link clicked");
  }

  // Function to share via WhatsApp
  void shareViaWhatsApp() {
    // Add code to share via WhatsApp
    print("WhatsApp clicked");
  }

  // Function to add via phone number
  void addViaPhoneNumber() {
    // Add code to add via phone number
    print("Add via phone number clicked");
  }

  // Function to add from contacts
  void addFromContacts() {
    // Add code to add from contacts
    print("Add from contacts clicked");
  }

  // Function to scan QR code
  void scanQRCode() {
    // Add code to scan QR code
    print("QR Code clicked");
  }

  void addContactToAPI(String name, String phoneNumber) {
    // Implement your API call here to add the contact
    // For example:
    // final response = await apiService.addContact(name, phoneNumber);
    // Handle the response accordingly
    print("Adding Contact: Name = $name, Phone = $phoneNumber");
    Get.snackbar("Success", "Contact added: $name");
  }
  // ----- Api -----

  Future<void> addCaptainWiketApi(String teamId, captainId, wiketKeeperId,
      screen, squadLength, image) async {
    final controller = await Get.put(SharedPreferencesController());

    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();

      var response = await startMatchRepo.addCaptainWiketApi(
          token!, teamId, captainId, wiketKeeperId);
      if (response.status == 200) {
        Utils.toastMessage(response.message.toString());
        final controller = await Get.put(SharedPreferencesController());

        selectedPlayerIds.clear();
        selectedCaptainId.value = '';
        selectedWicketKeeperId.value = '';
        selectedPosition.value = 'Captain';
        if (screen == 'OpponentsScreen') {
          controller.saveOpponentTeamId(teamId);
        } else {
          controller.saveTeamId(teamId);
        }
        String? team_id = await controller.getTeamId();
        String? oppnentteamId = await controller.getOpponentTeamId();

        if (team_id != null && oppnentteamId != null) {
          if (kDebugMode) {
            print("condition 1");
          }
          Get.off(MatchScreen(), transition: Transition.rightToLeft);
        } else if (screen == 'OpponentsScreen' &&
            team_id == null &&
            oppnentteamId != null) {
          if (kDebugMode) {
            print("condition 2");
          }

          Get.offAll(
              SelectTeamsScreens(
                oppnumberofSquad: squadLength,
                opptitle: squadLength,
                oppteamLogo: image,
              ),
              transition: Transition.rightToLeft);
        } else {
          if (kDebugMode) {
            print("condition 3");
          }
          Get.offAll(
              SelectTeamsScreens(
                numberofSquad: squadLength,
                title: squadLength,
                teamLogo: image,
              ),
              transition: Transition.rightToLeft);
        }
      } else if (response.status == 201) {
        Utils.toastMessage("Select Wicket Keeper!");
      }
      isDataLoad.value = false;
    } catch (e) {
      isDataLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  // ----- Api -----

  Future<void> addPlayerApi(
    String teamId,
    phone,
    playerName,
  ) async {
    final controller = await Get.put(SharedPreferencesController());

    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();

      var response =
          await startMatchRepo.addPlayerApi(token!, teamId, phone, playerName);
      if (response.status == 200 || response.status == 201) {
        teamPlayerListApi(teamId);
        Get.back();
        Utils.toastMessage(response.message.toString());
      }
      isDataLoad.value = false;
    } catch (e) {
      isDataLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class Member {
  String name;
  RxBool isSelected;

  Member(this.name, bool selected) : isSelected = RxBool(selected);
}
