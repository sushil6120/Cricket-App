import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:you_got_world/model/preStartMatchModel.dart';
import 'package:you_got_world/services/sharedPrefs.dart';

import '../repo/startMatchRepo.dart';
import '../themes/colors.dart';
import '../utils/utilsFunction.dart';

class MatchController extends GetxController {
  StartMatchRepo startMatchRepo = StartMatchRepo();

  var selectedMatchType = 'Limited Overs'.obs;
  var selectedPitchType = 'Turf'.obs;
  var selectedInputeType = ''.obs;
  var showOverPerBowlerType = ''.obs;
  var power_play = ''.obs;
  var over_per_pair = ''.obs;
  var match_ball = ''.obs;
  var selectedCityType = ''.obs;
  var matchId = ''.obs;
  var selectedDob = 'DATE'.obs;

  var isScheduleLoad = false.obs;

  var selectedBallType = ''.obs;
  var isDataLoad = false.obs;
  var isLoading = true.obs;

  RxList<BallType> ballType = <BallType>[].obs;
  RxList<PitchType> pitchType = <PitchType>[].obs;
  RxList<MatchType> matchType = <MatchType>[].obs;
  Rx<PreStartMatchModel> preStartMatchData =
      Rx<PreStartMatchModel>(PreStartMatchModel());

  var wagonwheel = false.obs;
  final List<String> ballTypes = ['TENNIS', 'LEATHER', 'OTHER'];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tempMatchApi();
  }

  void selectMatchType(String type, inpute, showOverPerBowler, powerPlay,
      overPerPair, matchBall) {
    selectedMatchType.value = type;
    selectedInputeType.value = inpute;
    showOverPerBowlerType.value = showOverPerBowler;
    power_play.value = powerPlay;
    over_per_pair.value = powerPlay;
    match_ball.value = matchBall;
  }

  void selectPitchType(String type) {
    selectedPitchType.value = type;
  }

  void selectBallType(String type) {
    selectedBallType.value = type;
  }

  void setWagonWheel(bool value) {
    wagonwheel.value = value;
  }
  // ----- Api -----

  Future<void> tempMatchApi() async {
    ballType.clear();
    pitchType.clear();
    final controller = await Get.put(SharedPreferencesController());

    try {
      isDataLoad.value = true;
      String? token = await controller.getToken();
      String? teamId = await controller.getTeamId();
      String? opponentTeamId = await controller.getOpponentTeamId();

      var response =
          await startMatchRepo.tempMatchApi(token!, teamId, opponentTeamId);
      if (response.status == 200 || response.status == 201) {
        matchId.value = response.data!.matchId.toString();
        preStartMatchApi(response.data!.matchId.toString());

        print(response);
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

  Future<void> preStartMatchApi(String matchId) async {
    final controller = await Get.put(SharedPreferencesController());
    matchType.clear();
    ballType.clear();
    pitchType.clear();
    try {
      isLoading.value = true;
      String? token = await controller.getToken();

      var response = await startMatchRepo.preStartMatchApi(token!, matchId);
      if (response.status == 200 || response.status == 201) {
        preStartMatchData.value = response;

        matchType.addAll(response.data!.matchType!.toList());
        ballType.addAll(response.data!.ballType!.toList());
        pitchType.addAll(response.data!.pitchType!.toList());
        controller.removeData('teamId');
        controller.removeData('oppoTeamId');
        print(response);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  // --

  // ----- Sgedule match ====

  Future<void> scheduleMAtchApi({
    required String matchId,
    String? matchType,
    String? noOfOvers,
    String? overPerBaller,
    String? powerPlayA,
    String? powerPlayB,
    String? powerPlayC,
    String? overPerPair,
    String? matchBall,
    String? cityTownId,
    String? groundId,
    String? matchDate,
    String? matchTime,
    String? ballType,
    String? wagonWheelActive,
    String? pitchType,
    String? firstUmpire,
    String? secondUmpire,
    String? thirdUmpire,
    String? fourthUmpire,
    String? firstScorer,
    String? secondScorer,
    String? commentators,
    String? matchReferee,
    String? liveStreamer,
  }) async {
    final controller = await Get.put(SharedPreferencesController());
    isScheduleLoad.value = true;

    try {
      String? token = await controller.getToken();
      var response = await startMatchRepo.matchScheduleApi(
          authToken: token!,
          matchId: matchId,
          ballType: ballType,
          cityTownId: cityTownId,
          commentators: commentators,
          firstScorer: firstScorer,
          firstUmpire: firstUmpire,
          fourthUmpire: fourthUmpire,
          groundId: groundId,
          liveStreamer: liveStreamer,
          matchBall: matchBall,
          matchDate: matchDate,
          matchTime: matchTime,
          matchReferee: matchReferee,
          matchType: matchType,
          noOfOvers: noOfOvers,
          overPerBaller: overPerBaller,
          overPerPair: overPerPair,
          pitchType: pitchType,
          powerPlayA: powerPlayA,
          powerPlayB: powerPlayB,
          powerPlayC: powerPlayC,
          secondScorer: secondScorer,
          secondUmpire: secondUmpire,
          thirdUmpire: thirdUmpire,
          wagonWheelActive: wagonWheelActive);
      isScheduleLoad.value = false;
      if (response.status == 200) {
        // Get.to(TossScreen(), transition: Transition.rightToLeft);
        Utils.toastMessage(response.message.toString());
      } else {
        Utils.toastMessage(response.message.toString());
      }
    } catch (e) {
      isScheduleLoad.value = false;
      Utils.toastMessage(e.toString());
    }
  }



  //

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, Widget? child) {
        return Theme(
            data: ThemeData(
              primaryColor: primaryColor,
              colorScheme: ColorScheme.light(primary: primaryColor),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.black,
                hourMinuteTextColor: Colors.white,
                dayPeriodColor: primaryColor,
                hourMinuteColor: Colors.grey.shade800,
                dialBackgroundColor: Colors.grey.shade800,
                dialTextColor: MaterialStateColor.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                  return Colors.white;
                }),
                entryModeIconColor: primaryColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor,
                ),
              ),
            ),
            child: child!);
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      selectedDob.value = formattedDate;
    }
  }

  // ---
}
