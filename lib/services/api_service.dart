import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study/services/api_responses/user_dto.dart';

class ApiService {
  final String _baseUrl;
  final http.Client _client = http.Client();

  ApiService(this._baseUrl);

  Future<List<UserDTO>> getUsers() async {
    final url = Uri.parse('$_baseUrl/users');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> result = jsonDecode(body);
      return result.map((e) => UserDTO.fromJson(e)).toList();
    }
    throw 'Bad case';
  }

  Future<UserDTO> getUser() async {
    final url = Uri.parse('$_baseUrl/users/octocat');
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      final body = response.body;
      final Map<String, dynamic> result = jsonDecode(body);
      return UserDTO.fromJson(result);
    }
    throw 'Bad case';
  }
}
