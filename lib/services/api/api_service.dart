import 'dart:convert';

import 'package:http/http.dart' as http;
import 'responses/issue_dto.dart';
import 'responses/search_issues_dto.dart';
import 'responses/user_dto.dart';

part 'issues_api.dart';
part 'users_api.dart';

class ApiService {
  final Uri _baseUri;
  final http.Client _client;
  final Map<String, String> _defaultHeaders = {
    'Accept': 'application/vnd.github.v3+jsons'
  };

  ApiService(String baseUrl, String token, {http.Client? client})
      : _baseUri = Uri.parse(baseUrl),
        _client = client ?? http.Client() {
    _defaultHeaders['Authorization'] = 'Bearer $token';
  }

  List<T> _parseList<T>(http.Response response, T Function(dynamic) parser) {
    print(response.statusCode);
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> result = jsonDecode(body);
      return result.map(parser).toList();
    }
    throw 'Failed to parse list response ${response.request?.url}';
  }

  T _parseObject<T>(
      http.Response response, T Function(Map<String, dynamic>) parser) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = response.body;
      final Map<String, dynamic> result = jsonDecode(body);
      return parser(result);
    }
    throw 'Failed to parse object response ${response.request?.url}';
  }
}
