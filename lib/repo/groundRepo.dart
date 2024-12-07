import 'dart:convert';

import '../model/searchGroundModel.dart';
import '../services/http_service.dart';
import '../utils/apiUrl.dart';

class GroundRepo {
  ApiService apiService = ApiService();

  Future<SearchGroundModel> searchGroundApi(
      String token, search_key, pageNo) async {
    final response = await apiService.post(
      ApiUrl.searchGroundApi,
      headers: {"Content-type": "application/json"},
      body: {"auth_token": token, "ground_name": search_key, "pageNo": pageNo},
    );
    print(response.body);
    return SearchGroundModel.fromJson(json.decode(response.body));
  }
}
