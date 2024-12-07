class ApiUrl {
  static final String baseUrl = "https://cricketapi.makevision.in/api";
  static final String registrationApi = "$baseUrl/registration";
  static final String loginApi = "$baseUrl/login";
  static final String otpVerifyApi = "$baseUrl/verify/otp";
  static final String userProfileApi = "$baseUrl/user/profiles";
  static final String resendOtpApi = "$baseUrl/resend/otp";
  static final String updateProfileApi = "$baseUrl/user/profile/update";
  static final String profileParameterApi = "$baseUrl/user/profile/parameters";
  static final String locationLocalAreaApi = "$baseUrl/location/local-area";
  static final String createTeamApiApi = "$baseUrl/cricket/create_my_team";
  static final String myTeamListApi = "$baseUrl/cricket/my_team_lists";
  static final String teamPlayerListApi = "$baseUrl/cricket/team_players";
  static final String opponentTeamListApi =
      "$baseUrl/cricket/opponent_team_lists";
  static final String createOpponentTeamApi =
      "$baseUrl/cricket/add_opponent_team";
  static final String selectCaptainWiketApi =
      "$baseUrl/cricket/select_captain_wicket_keeper";
  static final String addPlayerApi = "$baseUrl/cricket/add_new_player";
  static final String tempMatchApi = "$baseUrl/cricket/pre_start_temp_match";
  static final String preStartMatchApi = "$baseUrl/cricket/pre_start_match";
  static final String searchGroundApi = "$baseUrl/community/search_ground";
  static final String scheduleMatchApi = "$baseUrl/cricket/match_schedule_start";
  static final String tossUpdateApi = "$baseUrl/cricket/Toss_Update";
  static final String teamDetailsApi = "$baseUrl/cricket/Team_Lists";
  
  // --- community

  static final String scorersApi = "$baseUrl/community/search_scorer";
  static final String preGroundDataApi = "$baseUrl/community/pre_data_for_ground_booking";
  static final String addFullGroundDataApi = "$baseUrl/community/add_full_ground_details";
  static final String addScorerApi = "$baseUrl/community/add_scorer";

}
