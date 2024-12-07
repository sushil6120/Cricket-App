class PreStartMatchModel {
  int? status;
  String? message;
  Data? data;

  PreStartMatchModel({this.status, this.message, this.data});

  PreStartMatchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  TeamA? teamA;
  TeamA? teamB;
  List<BallType>? ballType;
  List<PitchType>? pitchType;
  List<MatchType>? matchType;
  String? wagonWheelInputTitle;
  List<MatchOfficials>? matchOfficials;

  Data(
      {this.teamA,
      this.teamB,
      this.ballType,
      this.pitchType,
      this.matchType,
      this.wagonWheelInputTitle,
      this.matchOfficials});

  Data.fromJson(Map<String, dynamic> json) {
    teamA = json['team_a'] != null ? new TeamA.fromJson(json['team_a']) : null;
    teamB = json['team_b'] != null ? new TeamA.fromJson(json['team_b']) : null;
    if (json['ball_type'] != null) {
      ballType = <BallType>[];
      json['ball_type'].forEach((v) {
        ballType!.add(new BallType.fromJson(v));
      });
    }
    if (json['pitch_type'] != null) {
      pitchType = <PitchType>[];
      json['pitch_type'].forEach((v) {
        pitchType!.add(new PitchType.fromJson(v));
      });
    }
    if (json['match_type'] != null) {
      matchType = <MatchType>[];
      json['match_type'].forEach((v) {
        matchType!.add(new MatchType.fromJson(v));
      });
    }
    wagonWheelInputTitle = json['wagon_wheel_input_title'];
    if (json['match_officials'] != null) {
      matchOfficials = <MatchOfficials>[];
      json['match_officials'].forEach((v) {
        matchOfficials!.add(new MatchOfficials.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.teamA != null) {
      data['team_a'] = this.teamA!.toJson();
    }
    if (this.teamB != null) {
      data['team_b'] = this.teamB!.toJson();
    }
    if (this.ballType != null) {
      data['ball_type'] = this.ballType!.map((v) => v.toJson()).toList();
    }
    if (this.pitchType != null) {
      data['pitch_type'] = this.pitchType!.map((v) => v.toJson()).toList();
    }
    if (this.matchType != null) {
      data['match_type'] = this.matchType!.map((v) => v.toJson()).toList();
    }
    data['wagon_wheel_input_title'] = this.wagonWheelInputTitle;
    if (this.matchOfficials != null) {
      data['match_officials'] =
          this.matchOfficials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamA {
  String? teamProfile;
  String? name;
  int? totalSqad;

  TeamA({this.teamProfile, this.name, this.totalSqad});

  TeamA.fromJson(Map<String, dynamic> json) {
    teamProfile = json['team_profile'];
    name = json['name'];
    totalSqad = json['total_sqad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_profile'] = this.teamProfile;
    data['name'] = this.name;
    data['total_sqad'] = this.totalSqad;
    return data;
  }
}

class BallType {
  String? ballId;
  String? ballName;
  String? ballImage;

  BallType({this.ballId, this.ballName, this.ballImage});

  BallType.fromJson(Map<String, dynamic> json) {
    ballId = json['ball_id'];
    ballName = json['ball_name'];
    ballImage = json['ball_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ball_id'] = this.ballId;
    data['ball_name'] = this.ballName;
    data['ball_image'] = this.ballImage;
    return data;
  }
}

class PitchType {
  String? pitchId;
  String? pitchName;

  PitchType({this.pitchId, this.pitchName});

  PitchType.fromJson(Map<String, dynamic> json) {
    pitchId = json['pitch_id'];
    pitchName = json['pitch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pitch_id'] = this.pitchId;
    data['pitch_name'] = this.pitchName;
    return data;
  }
}

class MatchType {
  String? matchTypeId;
  String? matchTypeName;
  MatchTypeInput? matchTypeInput;

  MatchType({this.matchTypeId, this.matchTypeName, this.matchTypeInput});

  MatchType.fromJson(Map<String, dynamic> json) {
    matchTypeId = json['match_type_id'];
    matchTypeName = json['match_type_name'];
    matchTypeInput = json['match_type_input'] != null
        ? new MatchTypeInput.fromJson(json['match_type_input'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_type_id'] = this.matchTypeId;
    data['match_type_name'] = this.matchTypeName;
    if (this.matchTypeInput != null) {
      data['match_type_input'] = this.matchTypeInput!.toJson();
    }
    return data;
  }
}

class MatchTypeInput {
  NoOfOvers? noOfOvers;
  OverPerBowler? overPerBowler;
  PowerPlay? powerPlay;
  PowerPlay? overPerPair;
  MatchBall? matchBall;

  MatchTypeInput(
      {this.noOfOvers,
      this.overPerBowler,
      this.powerPlay,
      this.overPerPair,
      this.matchBall});

  MatchTypeInput.fromJson(Map<String, dynamic> json) {
    noOfOvers = json['No_of_overs'] != null
        ? new NoOfOvers.fromJson(json['No_of_overs'])
        : null;
    overPerBowler = json['Over_per_bowler'] != null
        ? new OverPerBowler.fromJson(json['Over_per_bowler'])
        : null;
    powerPlay = json['Power_play'] != null
        ? new PowerPlay.fromJson(json['Power_play'])
        : null;
    overPerPair = json['Over_per_pair'] != null
        ? new PowerPlay.fromJson(json['Over_per_pair'])
        : null;
    matchBall = json['Match_ball'] != null
        ? new MatchBall.fromJson(json['Match_ball'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.noOfOvers != null) {
      data['No_of_overs'] = this.noOfOvers!.toJson();
    }
    if (this.overPerBowler != null) {
      data['Over_per_bowler'] = this.overPerBowler!.toJson();
    }
    if (this.powerPlay != null) {
      data['Power_play'] = this.powerPlay!.toJson();
    }
    if (this.overPerPair != null) {
      data['Over_per_pair'] = this.overPerPair!.toJson();
    }
    if (this.matchBall != null) {
      data['Match_ball'] = this.matchBall!.toJson();
    }
    return data;
  }
}

class NoOfOvers {
  String? showInput;
  int? maxOver;

  NoOfOvers({this.showInput, this.maxOver});

  NoOfOvers.fromJson(Map<String, dynamic> json) {
    showInput = json['show_input'];
    maxOver = json['max_over'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_input'] = this.showInput;
    data['max_over'] = this.maxOver;
    return data;
  }
}

class OverPerBowler {
  String? showInput;
  Null? maxValue;

  OverPerBowler({this.showInput, this.maxValue});

  OverPerBowler.fromJson(Map<String, dynamic> json) {
    showInput = json['show_input'];
    maxValue = json['max_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_input'] = this.showInput;
    data['max_value'] = this.maxValue;
    return data;
  }
}

class PowerPlay {
  String? showInput;
  int? maxValue;

  PowerPlay({this.showInput, this.maxValue});

  PowerPlay.fromJson(Map<String, dynamic> json) {
    showInput = json['show_input'];
    maxValue = json['max_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_input'] = this.showInput;
    data['max_value'] = this.maxValue;
    return data;
  }
}

class MatchBall {
  String? showInput;
  int? maxBall;

  MatchBall({this.showInput, this.maxBall});

  MatchBall.fromJson(Map<String, dynamic> json) {
    showInput = json['show_input'];
    maxBall = json['max_ball'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_input'] = this.showInput;
    data['max_ball'] = this.maxBall;
    return data;
  }
}

class MatchOfficials {
  String? title;
  String? iconImage;

  MatchOfficials({this.title, this.iconImage});

  MatchOfficials.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    iconImage = json['Icon_Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['Icon_Image'] = this.iconImage;
    return data;
  }
}
