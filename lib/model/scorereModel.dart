class ScorersModel {
  int? status;
  String? message;
  Data? data;

  ScorersModel({this.status, this.message, this.data});

  ScorersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0; // Default to 0 if null
    message = json['message'] ?? ''; // Default to empty string if null
    data = json['data'] != null ? Data.fromJson(json['data']) : Data(); // Provide empty Data if null
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status ?? 0;
    data['message'] = this.message ?? '';
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Scorer>? scorer;

  Data({this.scorer});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['scorer'] != null) {
      scorer = <Scorer>[];
      json['scorer'].forEach((v) {
        scorer!.add(Scorer.fromJson(v));
      });
    } else {
      scorer = []; // Default to empty list if 'scorer' is null
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.scorer != null) {
      data['scorer'] = this.scorer!.map((v) => v.toJson()).toList();
    } else {
      data['scorer'] = []; // Ensure empty list if scorer is null
    }
    return data;
  }
}

class Scorer {
  String? name;
  String? isVerified;
  String? scorerId;
  String? profile;
  String? perDayMatchFee;
  String? perMatchFee;
  int? ranking;
  String? ratting;
  String? totalReview;
  int? totalMatch;

  Scorer(
      {this.name,
      this.isVerified,
      this.scorerId,
      this.profile,
      this.perDayMatchFee,
      this.perMatchFee,
      this.ranking,
      this.ratting,
      this.totalReview,
      this.totalMatch});

  Scorer.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? ''; // Default to empty string if null
    isVerified = json['is_verified'] ?? ''; // Default to empty string if null
    scorerId = json['scorer_id'] ?? ''; // Default to empty string if null
    profile = json['profile'] ?? ''; // Default to empty string if null
    perDayMatchFee = json['per_day_match_fee'] ?? ''; // Default to empty string if null
    perMatchFee = json['per_match_fee'] ?? ''; // Default to empty string if null
    ranking = json['ranking'] ?? 0; // Default to 0 if null
    ratting = json['ratting'] ?? ''; // Default to empty string if null
    totalReview = json['total_review'] ?? ''; // Default to empty string if null
    totalMatch = json['total_match'] ?? 0; // Default to 0 if null
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = this.name ?? '';
    data['is_verified'] = this.isVerified ?? '';
    data['scorer_id'] = this.scorerId ?? '';
    data['profile'] = this.profile ?? '';
    data['per_day_match_fee'] = this.perDayMatchFee ?? '';
    data['per_match_fee'] = this.perMatchFee ?? '';
    data['ranking'] = this.ranking ?? 0;
    data['ratting'] = this.ratting ?? '';
    data['total_review'] = this.totalReview ?? '';
    data['total_match'] = this.totalMatch ?? 0;
    return data;
  }
}
