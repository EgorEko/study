import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study/services/api/responses/issue_dto.dart';
import 'responses/user_dto.dart';

part 'issues_api.dart';
part 'users_api.dart';

class ApiService {
  final Uri _baseUri;
  final http.Client _client = http.Client();
  final Map<String, String> _defaultHeaders = {
    'Accept': 'application/vnd.github.v3+jsons'
  };

  ApiService(String baseUrl) : _baseUri = Uri.parse(baseUrl);

  List<T> _parseList<T>(http.Response response, T Function(dynamic) parser) {
    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> result = jsonDecode(body);
      return result.map(parser).toList();
    }
    throw 'Failed to parse list response ${response.request?.url}';
  }

  T _parseObject<T>(
      http.Response response, T Function(Map<String, dynamic>) parser) {
    if (response.statusCode == 200) {
      final body = response.body;
      final Map<String, dynamic> result = jsonDecode(body);
      return parser(result);
    }
    throw 'Failed to parse object response ${response.request?.url}';
  }
}
