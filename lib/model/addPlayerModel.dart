class AddPlayerModel {
  int? status;
  String? message;
  // Data? data;

  AddPlayerModel({this.status, this.message, });

  AddPlayerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
 
    return data;
  }
}

class Data {
  List<MyTeam>? myTeam;

  Data({this.myTeam});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['my_team'] != null) {
      myTeam = <MyTeam>[];
      json['my_team'].forEach((v) {
        myTeam!.add(new MyTeam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.myTeam != null) {
      data['my_team'] = this.myTeam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyTeam {
  String? playerId;
  String? playerName;
  String? playerProfile;

  MyTeam({this.playerId, this.playerName, this.playerProfile});

  MyTeam.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    playerProfile = json['player_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['player_profile'] = this.playerProfile;
    return data;
  }
}
