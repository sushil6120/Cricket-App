import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:you_got_world/model/addScorerModel.dart';
import 'package:you_got_world/model/addfullGroundModel.dart';
import 'package:you_got_world/utils/apiUrl.dart';

import '../model/preCompleteGroundModel.dart';
import '../model/scorereModel.dart';
import '../services/http_service.dart';
import 'package:http/http.dart' as http;

class CommunityRepo {
  ApiService apiService = ApiService();

  Future<ScorersModel> scorersApi(String token, name, pageNo) async {
    final response = await apiService.post(
      ApiUrl.scorersApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "name": name,
        "pageNo": pageNo,
      },
    );
    return ScorersModel.fromJson(json.decode(response.body));
  }

  Future<PreCompleteGroundDataModel> AddCompleteGroundDataApi(
    String token,
  ) async {
    final response = await apiService.post(
      ApiUrl.preGroundDataApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
      },
    );
    return PreCompleteGroundDataModel.fromJson(json.decode(response.body));
  }

  Future<AddFullGroundModel> AddCompleteGroundApi(
      String token,
      ground_name,
      ground_address,
      contact_person,
      primary_contact_no,
      secondary_contact_no,
      email_id,
      shortes_length,
      longest_length,
      facilities,
      pitch_type,
      min_fee,
      max_fee) async {
    final response = await apiService.post(
      ApiUrl.addFullGroundDataApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
        "ground_name": ground_name,
        "ground_address": ground_address,
        "contact_person": contact_person,
        "primary_contact_no": primary_contact_no,
        "secondary_contact_no": secondary_contact_no,
        "email_id": email_id,
        "shortes_length": shortes_length,
        "longest_length": longest_length,
        "facilities": facilities,
        "pitch_type": pitch_type,
        "min_fee": min_fee,
        "max_fee": max_fee,
      },
    );
    return AddFullGroundModel.fromJson(json.decode(response.body));
  }

  Future<AddScorerModel> addScorerApi(
    File? profileImagePath,
    String authToken,
    String scorer_phone,
    String fee_per_match,
    String fee_per_day,
    String name,
    String total_expriance,
    String city_id,
  ) async {
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.addScorerApi));

    // Add headers
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
    });

    // Add text fields
    request.fields['auth_token'] = authToken;
    request.fields['scorer_name'] = name;
    request.fields['scorer_phone'] = scorer_phone;
    request.fields['fee_per_match'] = fee_per_match;
    request.fields['fee_per_day'] = fee_per_day;
    request.fields['total_expriance'] = total_expriance;
    request.fields['city_id'] = city_id;

    // Add profile image file
    if (profileImagePath != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile', profileImagePath.path),
      );
    }

    // Send the request
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if (kDebugMode) {
        print(responseBody);
      }
      if (kDebugMode) {
        print(responseBody);
      }
      return AddScorerModel.fromJson(json.decode(responseBody));
    } else {
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      print(response.statusCode);
      throw Exception('Failed to add scorer');
    }
  }
}
