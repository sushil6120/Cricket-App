class OtpVerifyModel {
  int? status;
  String? message;
  Data? data;

  OtpVerifyModel({this.status, this.message, this.data});

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
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
  String? phoneNumber;
  String? accessToken;
  List<UserData>? userData;

  Data({this.phoneNumber, this.accessToken, this.userData});

  Data.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    accessToken = json['access_token'];
    if (json['user_data'] != null) {
      userData = <UserData>[];
      json['user_data'].forEach((v) {
        userData!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.phoneNumber;
    data['access_token'] = this.accessToken;
    if (this.userData != null) {
      data['user_data'] = this.userData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
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

  UserData(
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

  UserData.fromJson(Map<String, dynamic> json) {
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
