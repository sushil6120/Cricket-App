class PreCompleteGroundDataModel {
  int? status;
  String? message;
  Data? data;

  PreCompleteGroundDataModel({this.status, this.message, this.data});

  PreCompleteGroundDataModel.fromJson(Map<String, dynamic> json) {
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
  List<GroundFacilities>? groundFacilities;
  List<PitchType>? pitchType;

  Data({this.groundFacilities, this.pitchType});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ground_facilities'] != null) {
      groundFacilities = <GroundFacilities>[];
      json['ground_facilities'].forEach((v) {
        groundFacilities!.add(new GroundFacilities.fromJson(v));
      });
    }
    if (json['pitch_type'] != null) {
      pitchType = <PitchType>[];
      json['pitch_type'].forEach((v) {
        pitchType!.add(new PitchType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groundFacilities != null) {
      data['ground_facilities'] =
          this.groundFacilities!.map((v) => v.toJson()).toList();
    }
    if (this.pitchType != null) {
      data['pitch_type'] = this.pitchType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroundFacilities {
  String? facilityId;
  String? facilityName;
  String? showOtherFacilityInput;

  GroundFacilities(
      {this.facilityId, this.facilityName, this.showOtherFacilityInput});

  GroundFacilities.fromJson(Map<String, dynamic> json) {
    facilityId = json['facility_id'];
    facilityName = json['facility_name'];
    showOtherFacilityInput = json['show_other_facility_input'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facility_id'] = this.facilityId;
    data['facility_name'] = this.facilityName;
    data['show_other_facility_input'] = this.showOtherFacilityInput;
    return data;
  }
}

class PitchType {
  String? typeId;
  String? typeName;

  PitchType({this.typeId, this.typeName});

  PitchType.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    return data;
  }
}
