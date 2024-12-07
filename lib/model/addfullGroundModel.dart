class AddFullGroundModel {
  int? status;
  String? message;
  Data? data;

  AddFullGroundModel({this.status, this.message, this.data});

  AddFullGroundModel.fromJson(Map<String, dynamic> json) {
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
  List<Ground>? ground;

  Data({this.ground});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ground'] != null) {
      ground = <Ground>[];
      json['ground'].forEach((v) {
        ground!.add(new Ground.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ground != null) {
      data['ground'] = this.ground!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ground {
  String? groundName;
  String? groundId;

  Ground({this.groundName, this.groundId});

  Ground.fromJson(Map<String, dynamic> json) {
    groundName = json['ground_name'];
    groundId = json['ground_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ground_name'] = this.groundName;
    data['ground_id'] = this.groundId;
    return data;
  }
}
