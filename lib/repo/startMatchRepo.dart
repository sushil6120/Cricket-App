import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:you_got_world/model/createTeamModel.dart';
import 'package:http/http.dart' as http;
import 'package:you_got_world/model/myTeamListModel.dart';
import 'package:you_got_world/model/teamsDetailsModel.dart';
import 'package:you_got_world/model/temMatchModel.dart';
import 'package:you_got_world/view/scoringScreen.dart';

import '../model/addPlayerModel.dart';
import '../model/captainWicketKeeperModel.dart';
import '../model/opponentTeamListModel.dart';
import '../model/preStartMatchModel.dart';
import '../model/scheduleMtachModel.dart';
import '../model/teamPlayerModel.dart';
import '../services/http_service.dart';
import '../utils/apiUrl.dart';

class StartMatchRepo {
  ApiService apiService = ApiService();

  Future<CreateTeamModel> createTeamApi(
    File? team_logo,
    String authToken,
    String team_name,
    String location_city,
    String captain_phone_number,
    String captain_name,
    String self_add,
  ) async {
    // Create a multipart request
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.createTeamApiApi));

    // Add headers
    request.headers.addAll({
      "Authorization": "Bearer $authToken",
      "Content-Type": "multipart/form-data",
    });

    // Add text fields
    request.fields['auth_token'] = authToken;
    request.fields['team_name'] = team_name;
    request.fields['location_city'] = location_city;
    request.fields['captain_phone_number'] = captain_phone_number;
    request.fields['captain_name'] = captain_name;
    request.fields['self_add'] = self_add;

    // Add profile image file
    if (team_logo != null) {
      request.files.add(
        await http.MultipartFile.fromPath('team_logo', team_logo.path),
      );
    }

    // Send the request
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if (kDebugMode) {
        print(responseBody);
      }
      if (kDebugMode) {
        print(responseBody);
      }
      return CreateTeamModel.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to create team');
    }
  }

  // ---------

  Future<MyTeamListModel> myTeamListApi(
    String token,
  ) async {
    final response = await apiService.post(
      ApiUrl.myTeamListApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
      },
    );
    return MyTeamListModel.fromJson(json.decode(response.body));
  }
  // ---------

  Future<TeamPlayerModel> teamPlayerListApi(
    String token,
    teamId,
  ) async {
    final response = await apiService.post(
      ApiUrl.teamPlayerListApi,
      headers: {"Content-type": "application/json"},
      body: {"auth_token": token, "team_id": teamId},
    );
    return TeamPlayerModel.fromJson(json.decode(response.body));
  }
  // ---------

  Future<OpponentTeamListModel> opponentTeamListApi(
    String token,
  ) async {
    final response = await apiService.post(
      ApiUrl.opponentTeamListApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
      },
    );
    return OpponentTeamListModel.fromJson(json.decode(response.body));
  }

  Future<CreateTeamModel> createOpponentTeamApi(
    File? team_logo,
    String authToken,
    String team_name,
    String location_city,
    String captain_phone_number,
    String captain_name,
  ) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.createOpponentTeamApi));

    request.headers.addAll({
      "Authorization": "Bearer $authToken",
      "Content-Type": "multipart/form-data",
    });

    request.fields['auth_token'] = authToken;
    request.fields['team_name'] = team_name;
    request.fields['location_city'] = location_city;
    request.fields['coordinator_phone_number'] = captain_phone_number;
    request.fields['coordinator_name'] = captain_name;

    if (team_logo != null) {
      request.files.add(
        await http.MultipartFile.fromPath('team_logo', team_logo.path),
      );
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if (kDebugMode) {
        print(responseBody);
      }
      if (kDebugMode) {
        print(responseBody);
      }
      return CreateTeamModel.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to create team');
    }
  }

  // ---------

  Future<CaptainWicketKeeperModel> addCaptainWiketApi(
    String token,
    teamId,
    captainId,
    wiketKeeperId,
  ) async {
    final response = await apiService.post(
      ApiUrl.selectCaptainWiketApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "team_id": teamId,
        "captain_id_player_id": captainId,
        "wicket_keeper_player_id": wiketKeeperId,
      },
    );
    return CaptainWicketKeeperModel.fromJson(json.decode(response.body));
  }
  // ---------

  Future<AddPlayerModel> addPlayerApi(
    String token,
    teamId,
    phone,
    playerName,
  ) async {
    final response = await apiService.post(
      ApiUrl.addPlayerApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "team_id": teamId,
        "player_phone": phone,
        "player_name": playerName,
      },
    );
    return AddPlayerModel.fromJson(json.decode(response.body));
  }
  // ---------

  Future<TempMatchModel> tempMatchApi(
    String token,
    team_a_id,
    team_b_id,
  ) async {
    final response = await apiService.post(
      ApiUrl.tempMatchApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "team_a_id": team_a_id,
        "team_b_id": team_b_id,
      },
    );
    return TempMatchModel.fromJson(json.decode(response.body));
  }
  // ---------

  Future<PreStartMatchModel> preStartMatchApi(
    String token,
    match_id,
  ) async {
    final response = await apiService.post(
      ApiUrl.preStartMatchApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "match_id": match_id,
      },
    );

    if (kDebugMode) {
      print(response.body);
    }
    return PreStartMatchModel.fromJson(json.decode(response.body));
  }

  // ======

  Future<ScheduleMatchModel> matchScheduleApi({
    required String authToken,
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
    Map<String, dynamic> body = {
      'auth_token': authToken,
      'match_id': matchId,
      'match_type': matchType ?? '',
      'no_of_overs': noOfOvers ?? '',
      'over_per_baller': overPerBaller ?? '',
      'power_play_a': powerPlayA ?? '',
      'power_play_b': powerPlayB ?? '',
      'power_play_c': powerPlayC ?? '',
      'over_per_pair': overPerPair ?? '',
      'match_ball': matchBall ?? '',
      'city_town_id': cityTownId ?? '',
      'ground_id': groundId ?? '',
      'match_date': matchDate ?? '',
      'match_time': matchTime ?? '',
      'ball_type': ballType ?? '',
      'wagon_wheel_active': wagonWheelActive ?? '',
      'pitch_type': pitchType ?? '',
      'first_umpire': firstUmpire ?? '',
      'second_umpire': secondUmpire ?? '',
      'third_umpire': thirdUmpire ?? '',
      'fourth_umpire': fourthUmpire ?? '',
      'first_scorer': firstScorer ?? '',
      'second_scorer': secondScorer ?? '',
      'commentators': commentators ?? '',
      'match_referee': matchReferee ?? '',
      'live_streamer': liveStreamer ?? ''
    };

    final response = await apiService.post(
      ApiUrl.scheduleMatchApi,
      headers: {"Content-type": "application/json"},
      body: body,
    );

    if (kDebugMode) {
      print(response.body);
    }
    return ScheduleMatchModel.fromJson(json.decode(response.body));
  }

  // ---- Toss Match Api --

  Future<void> tossmatchApi(
    String token,
    matchId,
    toss_status,
    toss_winner_team,
    toss_bidd_by_team_a,
    toss_bidd_by_team_b,
    select_batting_team_id,
    select_bowling_team_id,
    toss_looser_team_id,
  ) async {
    final response = await apiService.post(
      ApiUrl.tossUpdateApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "match_id": matchId,
        "toss_status": toss_status,
        "toss_winner_team": toss_winner_team,
        "toss_bidd_by_team_a": toss_bidd_by_team_a,
        "toss_bidd_by_team_b": toss_bidd_by_team_b,
        "select_batting_team_id": select_batting_team_id,
        "select_bowling_team_id": select_bowling_team_id,
        "toss_looser_team_id": toss_looser_team_id,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.to(ScoringScreen(), transition: Transition.rightToLeft);
    }
    print(response.body);
  }
  // ---- Team Details Api --

  Future<TeamDetailsModel> teamDeatilsApi(
    String token,
    matchId,
  ) async {
    final response = await apiService.post(
      ApiUrl.teamDetailsApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "match_id": matchId,
      },
    );

    print(response.body);
    return TeamDetailsModel.fromJson(json.decode(response.body));
  }
}
