import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:you_got_world/repo/startMatchRepo.dart';
import 'package:you_got_world/services/sharedPrefs.dart';

import '../model/teamsDetailsModel.dart';

class TossController extends GetxController {
  StartMatchRepo startMatchRepo = StartMatchRepo();

  var isDataLoad = false.obs;
  var isLoading = true.obs;
  var selectedTeam = ''.obs;
  var selectedOption = ''.obs;
  var isCoinFlipped = false.obs;
  var flipResult = ''.obs;

  Rx<TeamDetailsModel> teaDetailsData =
      Rx<TeamDetailsModel>(TeamDetailsModel());

  void selectTeam(String team) {
    selectedTeam.value = team;
  }

  void selectOption(String option) {
    selectedOption.value = option;
  }

  void flipCoin() {
    isCoinFlipped.value = true;
    final random = Random();
    flipResult.value = (random.nextInt(2) == 0) ? 'Heads' : 'Tails';
  }

  void resetToss() {
    selectedTeam.value = '';
    selectedOption.value = '';
    isCoinFlipped.value = false;
    flipResult.value = '';
  }

  //   Tosss Match Api ---

  Future<void> tossMathcApi(
      String matchId,
      toss_status,
      toss_winner_team,
      toss_bidd_by_team_a,
      toss_bidd_by_team_b,
      select_batting_team_id,
      select_bowling_team_id,
      toss_looser_team_id) async {
    final controller = await Get.put(SharedPreferencesController());

    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();

      var response = await startMatchRepo.tossmatchApi(
          token!,
          matchId,
          toss_status,
          toss_winner_team,
          toss_bidd_by_team_a,
          toss_bidd_by_team_b,
          select_batting_team_id,
          select_bowling_team_id,
          toss_looser_team_id);

      isDataLoad.value = false;
    } catch (e) {
      isDataLoad.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  //   Tosss Match Api ---

  Future<void> teamDetailsApi(
    String matchId,
  ) async {
    final controller = await Get.put(SharedPreferencesController());
    String? token = await controller.getToken();
    try {
      isLoading.value = true;

      var response = await startMatchRepo.teamDeatilsApi(token!, matchId);
      teaDetailsData.value = response;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
