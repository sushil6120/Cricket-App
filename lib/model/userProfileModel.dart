class UserProfileModel {
  int? status;
  String? message;
  List<Data>? data;

  UserProfileModel({this.status, this.message, this.data});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? profileImage;
  String? name;
  String? email;
  String? phone;
  String? location;
  String? playingRole;
  String? gender;
  String? dob;
  String? battingStyle;
  String? bowlingStyle;

  Data(
      {this.profileImage,
      this.name,
      this.email,
      this.phone,
      this.location,
      this.playingRole,
      this.gender,
      this.dob,
      this.battingStyle,
      this.bowlingStyle});

  Data.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    playingRole = json['playing_role'];
    gender = json['gender'];
    dob = json['dob'];
    battingStyle = json['batting_style'];
    bowlingStyle = json['bowling_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['playing_role'] = this.playingRole;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['batting_style'] = this.battingStyle;
    data['bowling_style'] = this.bowlingStyle;
    return data;
  }
}
