class ProfileParameterModel {
  int? status;
  String? message;
  Data? data;

  ProfileParameterModel({this.status, this.message, this.data});

  ProfileParameterModel.fromJson(Map<String, dynamic> json) {
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
  List<PlayingRole>? playingRole;
  List<BattingStyle>? battingStyle;
  List<BowlingStyle>? bowlingStyle;
  List<UserGender>? userGender;

  Data(
      {this.playingRole,
      this.battingStyle,
      this.bowlingStyle,
      this.userGender});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Playing_Role'] != null) {
      playingRole = <PlayingRole>[];
      json['Playing_Role'].forEach((v) {
        playingRole!.add(new PlayingRole.fromJson(v));
      });
    }
    if (json['Batting_Style'] != null) {
      battingStyle = <BattingStyle>[];
      json['Batting_Style'].forEach((v) {
        battingStyle!.add(new BattingStyle.fromJson(v));
      });
    }
    if (json['Bowling_Style'] != null) {
      bowlingStyle = <BowlingStyle>[];
      json['Bowling_Style'].forEach((v) {
        bowlingStyle!.add(new BowlingStyle.fromJson(v));
      });
    }
    if (json['User_Gender'] != null) {
      userGender = <UserGender>[];
      json['User_Gender'].forEach((v) {
        userGender!.add(new UserGender.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playingRole != null) {
      data['Playing_Role'] = this.playingRole!.map((v) => v.toJson()).toList();
    }
    if (this.battingStyle != null) {
      data['Batting_Style'] =
          this.battingStyle!.map((v) => v.toJson()).toList();
    }
    if (this.bowlingStyle != null) {
      data['Bowling_Style'] =
          this.bowlingStyle!.map((v) => v.toJson()).toList();
    }
    if (this.userGender != null) {
      data['User_Gender'] = this.userGender!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayingRole {
  String? playRole;
  int? fldId;

  PlayingRole({this.playRole, this.fldId});

  PlayingRole.fromJson(Map<String, dynamic> json) {
    playRole = json['playRole'];
    fldId = json['fld_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playRole'] = this.playRole;
    data['fld_id'] = this.fldId;
    return data;
  }
}

class BattingStyle {
  String? battingStyle;
  int? fldId;

  BattingStyle({this.battingStyle, this.fldId});

  BattingStyle.fromJson(Map<String, dynamic> json) {
    battingStyle = json['battingStyle'];
    fldId = json['fld_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['battingStyle'] = this.battingStyle;
    data['fld_id'] = this.fldId;
    return data;
  }
}

class BowlingStyle {
  String? blwlingStyle;
  int? fldId;

  BowlingStyle({this.blwlingStyle, this.fldId});

  BowlingStyle.fromJson(Map<String, dynamic> json) {
    blwlingStyle = json['blwlingStyle'];
    fldId = json['fld_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blwlingStyle'] = this.blwlingStyle;
    data['fld_id'] = this.fldId;
    return data;
  }
}

class UserGender {
  String? gender;
  int? fldId;

  UserGender({this.gender, this.fldId});

  UserGender.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    fldId = json['fld_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['fld_id'] = this.fldId;
    return data;
  }
}
