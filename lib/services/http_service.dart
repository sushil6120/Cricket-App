import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiService {
  ApiService();

  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    await _checkInternetConnection();
    final response = await http.get(Uri.parse(url), headers: headers);
    _checkForError(response);
    return response;
  }

  Future<http.Response> post(String url,
      {Map<String, String>? headers, dynamic body}) async {
    await _checkInternetConnection();
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );
    if (kDebugMode) {
      _checkForError(response);
    }
    return response;
  }

  Future<http.Response> put(String url,
      {Map<String, String>? headers, dynamic body}) async {
    await _checkInternetConnection();
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );
    _checkForError(response);
    return response;
  }

  Future<http.Response> patch(String url,
      {Map<String, String>? headers, dynamic body}) async {
    await _checkInternetConnection();
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );
    _checkForError(response);
    return response;
  }

  Future<http.Response> delete(String url,
      {Map<String, String>? headers}) async {
    await _checkInternetConnection();
    final response = await http.delete(Uri.parse(url), headers: headers);
    _checkForError(response);
    return response;
  }

  Future<http.StreamedResponse> multipartRequest(
    String url, {
    required Map<String, String> fields,
    required Map<String, String> headers,
    required List<http.MultipartFile> files,
  }) async {
    await _checkInternetConnection();

    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..fields.addAll(fields)
      ..headers.addAll(headers);

    for (var file in files) {
      request.files.add(file);
    }

    var streamedResponse = await request.send();
    if (streamedResponse.statusCode < 200 ||
        streamedResponse.statusCode >= 300) {
      final response = await http.Response.fromStream(streamedResponse);
      _checkForError(response);
    }

    return streamedResponse;
  }

  Future<http.StreamedResponse> multipartPutRequest(
    String url, {
    required Map<String, String> fields,
    required Map<String, String> headers,
    required http.MultipartFile file,
  }) async {
    await _checkInternetConnection();

    var uri = Uri.parse(url);
    var request = http.MultipartRequest('PUT', uri)
      ..fields.addAll(fields)
      ..headers.addAll(headers)
      ..files.add(file);

    var streamedResponse = await request.send();
    if (streamedResponse.statusCode < 200 ||
        streamedResponse.statusCode >= 300) {
      final response = await http.Response.fromStream(streamedResponse);
      _checkForError(response);
    }

    return streamedResponse;
  }

  Future<void> _checkInternetConnection() async {
    if (!await _isConnected()) {
      Get.snackbar(
        'Error',
        'No internet connection',
        icon: Icon(Icons.wifi_off, color: Colors.white),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('No internet connection');
    }
  }

  void _checkForError(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      Get.snackbar(
        'Error',
        'Failed to load data: ${response.statusCode} ${response.body}',
        icon: Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
