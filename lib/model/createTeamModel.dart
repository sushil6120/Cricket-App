class CreateTeamModel {
  int? status;
  String? message;
  Data? data;

  CreateTeamModel({this.status, this.message, this.data});

  CreateTeamModel.fromJson(Map<String, dynamic> json) {
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
  List<TeamList>? teamList;

  Data({this.teamList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['team_list'] != null) {
      teamList = <TeamList>[];
      json['team_list'].forEach((v) {
        teamList!.add(new TeamList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamList != null) {
      data['team_list'] = this.teamList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamList {
  String? teamId;
  String? teamName;
  String? teamCity;
  String? teamProfile;
  String? teamCordinater;

  TeamList(
      {this.teamId,
      this.teamName,
      this.teamCity,
      this.teamProfile,
      this.teamCordinater});

  TeamList.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
    teamCity = json['team_city'];
    teamProfile = json['team_profile'];
    teamCordinater = json['team_cordinater'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['team_city'] = this.teamCity;
    data['team_profile'] = this.teamProfile;
    data['team_cordinater'] = this.teamCordinater;
    return data;
  }
}
