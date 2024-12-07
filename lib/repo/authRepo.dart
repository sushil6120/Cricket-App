import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:you_got_world/model/loginModel.dart';
import 'package:you_got_world/model/otpVerifyModel.dart';
import 'package:you_got_world/model/updateProfileModel.dart';
import 'package:you_got_world/services/http_service.dart';
import 'package:http/http.dart' as http;
import '../model/registerModel.dart';
import '../utils/apiUrl.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  Future<LoginModel> loginApi(
      String phone, deviceId, latitude, longitude) async {
    final response = await apiService.post(
      ApiUrl.loginApi,
      headers: {"Content-type": "application/json"},
      body: {
        "phone_number": phone,
        "device_id": deviceId,
        "latitude": latitude,
        "longitude": longitude
      },
    );
    return LoginModel.fromJson(json.decode(response.body));
  }

  Future<LoginModel> resendOtpApi(
      String phone, deviceId, latitude, longitude) async {
    final response = await apiService.post(
      ApiUrl.resendOtpApi,
      headers: {"Content-type": "application/json"},
      body: {
        "phone_number": phone,
        "device_id": deviceId,
        "latitude": latitude,
        "longitude": longitude
      },
    );
    return LoginModel.fromJson(json.decode(response.body));
  }

  Future<OtpVerifyModel> otpVerifyApi(
      String phone, otp, deviceId, latitude, longitude) async {
    final response = await apiService.post(
      ApiUrl.otpVerifyApi,
      headers: {"Content-type": "application/json"},
      body: {
        "phone_number": phone,
        "otp": otp,
        "device_id": deviceId,
        "latitude": latitude,
        "longitude": longitude
      },
    );
    return OtpVerifyModel.fromJson(json.decode(response.body));
  }

  Future<RegisterModel> registerApi(
      String phone, deviceId, latitude, longitude, name, email) async {
    final response = await apiService.post(
      ApiUrl.registrationApi,
      headers: {"Content-type": "application/json"},
      body: {
        "phone_number": phone,
        "device_id": deviceId,
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "email_id": email,
      },
    );
    return RegisterModel.fromJson(json.decode(response.body));
  }

  Future<UpdateProfileModel> updateProfileApi(
    File? profileImagePath,
    String authToken,
    String locationId,
    String dob,
    String email,
    String name,
    String phone,
    String playingRole,
    String battingStyle,
    String bollingStyle,
    String gender,
    String secretPin,
  ) async {
    // Create a multipart request
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.updateProfileApi));

    // Add headers
    request.headers.addAll({
      "Authorization": "Bearer $authToken",
      "Content-Type": "multipart/form-data",
    });

    // Add text fields
    request.fields['auth_token'] = authToken;
    request.fields['name'] = name;
    request.fields['location'] = locationId;
    request.fields['date_of_birth'] = dob;
    request.fields['email_id'] = email;
    request.fields['phone_number'] = phone;
    request.fields['playing_role'] = playingRole;
    request.fields['batting_style'] = battingStyle;
    request.fields['bolling_style'] = bollingStyle;
    request.fields['gender'] = gender;
    request.fields['secret_pin'] = secretPin;

    // Add profile image file
    if (profileImagePath != null) {
      request.files.add(
        await http.MultipartFile.fromPath('profile_image', profileImagePath.path),
      );
    }

    // Send the request
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      if(kDebugMode){
        print(responseBody);
      }
       if(kDebugMode){
        print(responseBody);
      }
      return UpdateProfileModel.fromJson(json.decode(responseBody));
    } else {
        var responseBody = await response.stream.bytesToString();
      print(responseBody);
      throw Exception('Failed to update profile');
    }
  }
}
