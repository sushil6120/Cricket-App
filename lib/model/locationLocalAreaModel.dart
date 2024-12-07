class LocationLocalAreaModel {
  int? status;
  String? message;
  Data? data;

  LocationLocalAreaModel({this.status, this.message, this.data});

  LocationLocalAreaModel.fromJson(Map<String, dynamic> json) {
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
  List<Location>? location;

  Data({this.location});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(new Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? location;
  int? locationId;
  int? pincode;

  Location({this.location, this.locationId, this.pincode});

  Location.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    locationId = json['location_id'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['location_id'] = this.locationId;
    data['pincode'] = this.pincode;
    return data;
  }
}
