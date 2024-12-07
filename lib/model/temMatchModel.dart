class TempMatchModel {
  int? status;
  String? message;
  Data? data;

  TempMatchModel({this.status, this.message, this.data});

  TempMatchModel.fromJson(Map<String, dynamic> json) {
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
  String? matchId;

  Data({this.matchId});

  Data.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    return data;
  }
}
