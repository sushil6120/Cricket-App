import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:you_got_world/model/opponentTeamListModel.dart';
import 'package:you_got_world/services/sharedPrefs.dart';

import '../repo/startMatchRepo.dart';
import '../utils/utilsFunction.dart';

class OpponentController extends GetxController {
  StartMatchRepo startMatchRepo = StartMatchRepo();

  var isLoading = false.obs;
    final myTeamIndex = Rxn<int>();
  final teamId = Rxn<String>();
  final teamLogo = Rxn<String>();
    final teamNameValue = Rxn<String>();

  RxList<TeamList> opponentTeamData = <TeamList>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    opponentTeamListApi();
  }



   void setMyTeamIndex(int index) {
    myTeamIndex.value = index;
    print(myTeamIndex.value);
  }

  void setMyTeamData(String teamid, teamlogo, teamname) {
    teamId.value = teamid;
    teamLogo.value = teamlogo;
    teamNameValue.value = teamname;

    
  }

  // ----- Api -----

  Future<void> opponentTeamListApi() async {
    final controller = await Get.put(SharedPreferencesController());
    opponentTeamData.clear();
    try {
      isLoading.value = true;
      String? token = await controller.getToken();

      var response = await startMatchRepo.opponentTeamListApi(token!);
      opponentTeamData.value.addAll(response.data!.teamList!.toList());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

 
}
