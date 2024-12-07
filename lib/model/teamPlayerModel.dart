class TeamPlayerModel {
  int? status;
  String? message;
  Data? data;

  TeamPlayerModel({this.status, this.message, this.data});

  TeamPlayerModel.fromJson(Map<String, dynamic> json) {
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
  List<PlayerList>? playerList;

  Data({this.playerList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['player_list'] != null) {
      playerList = <PlayerList>[];
      json['player_list'].forEach((v) {
        playerList!.add(new PlayerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playerList != null) {
      data['player_list'] = this.playerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerList {
  String? playerId;
  String? playerName;
  String? playerProfile;

  PlayerList({this.playerId, this.playerName, this.playerProfile});

  PlayerList.fromJson(Map<String, dynamic> json) {
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
