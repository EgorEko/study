import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study/services/api_responses/user_dto.dart';

class ApiService {
  final Uri _baseUri;
  final http.Client _client = http.Client();

  ApiService(String baseUrl) : _baseUri = Uri.parse(baseUrl);

  Future<List<UserDTO>> getUsers({int perPage = 15, int? since}) async {
    final url = _baseUri.replace(
        path: 'users',
        queryParameters: <String, dynamic>{
          'per_page': perPage.toString(),
          if (since != null) 'since': since.toString()
        });
    final response = await _client
        .get(url, headers: {'Accept': 'application/vnd.github.v3+jsons'});
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> result = jsonDecode(body);
      return result.map((e) => UserDTO.fromJson(e)).toList();
    }
    throw 'Bad case';
  }

  Future<UserDTO> getUser(String user) async {
    final url = _baseUri.replace(path: 'users/$user');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      final body = response.body;
      final Map<String, dynamic> result = jsonDecode(body);
      return UserDTO.fromJson(result);
    }
    throw 'Bad case';
  }
}
