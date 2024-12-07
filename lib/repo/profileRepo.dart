import 'dart:convert';

import 'package:you_got_world/model/locationLocalAreaModel.dart';
import 'package:you_got_world/model/profileParameterModel.dart';
import 'package:you_got_world/model/userProfileModel.dart';
import 'package:you_got_world/services/http_service.dart';
import 'package:you_got_world/utils/apiUrl.dart';

class ProfileRepo {
  ApiService apiService = ApiService();

  Future<ProfileParameterModel> profileParameterApi(
    String token,
  ) async {
    final response = await apiService.post(
      ApiUrl.profileParameterApi,
      headers: {"Content-type": "application/json"},
      body: {"auth_token": token},
    );
    return ProfileParameterModel.fromJson(json.decode(response.body));
  }

  Future<LocationLocalAreaModel> locationLocalAreaApi(
    String token,
    search_key,
  ) async {
    final response = await apiService.post(
      ApiUrl.locationLocalAreaApi,
      headers: {"Content-type": "application/json"},
      body: {"auth_token": token, "search_key": search_key},
    );
    return LocationLocalAreaModel.fromJson(json.decode(response.body));
  }

  Future<UserProfileModel> userProfileApi(
    String token,
  ) async {
    final response = await apiService.post(
      ApiUrl.userProfileApi,
      headers: {"Content-type": "application/json"},
      body: {
        "auth_token": token,
      },
    );
    print("Response : ${response.body}");
    return UserProfileModel.fromJson(json.decode(response.body));
  }
}
