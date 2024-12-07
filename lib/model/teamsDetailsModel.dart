class TeamDetailsModel {
  int? status;
  String? message;
  Data? data;

  TeamDetailsModel({this.status, this.message, this.data});

  TeamDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? teamAId;
  String? teamBId;
  String? teamAName;
  String? teamBName;
  String? teamAProfile;
  String? teamBProfile;

  Data(
      {this.teamAId,
      this.teamBId,
      this.teamAName,
      this.teamBName,
      this.teamAProfile,
      this.teamBProfile});

  Data.fromJson(Map<String, dynamic> json) {
    teamAId = json['Team_A_Id'];
    teamBId = json['Team_B_Id'];
    teamAName = json['Team_A_Name'];
    teamBName = json['Team_B_Name'];
    teamAProfile = json['team_A_Profile'];
    teamBProfile = json['team_B_Profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Team_A_Id'] = this.teamAId;
    data['Team_B_Id'] = this.teamBId;
    data['Team_A_Name'] = this.teamAName;
    data['Team_B_Name'] = this.teamBName;
    data['team_A_Profile'] = this.teamAProfile;
    data['team_B_Profile'] = this.teamBProfile;
    return data;
  }
}
