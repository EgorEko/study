part of 'api_service.dart';

extension UsersApi on ApiService {
  Future<List<UserDTO>> getUsers({int perPage = 15, int? since}) async {
    final url = _baseUri.replace(
      path: 'users',
      queryParameters: <String, dynamic>{
        'per_page': perPage.toString(),
        if (since != null) 'since': since.toString(),
      },
    );
    final response = await _client
        .get(url, headers: {'Accept': 'application/vnd.github.v3+jsons'});
    return _parseList(response, (e) => UserDTO.fromJson(e));
  }

  Future<UserDTO> getUser(String user) async {
    final url = _baseUri.replace(path: 'users/$user');
    final response = await _client.get(url);
    return _parseObject(response, (e) => UserDTO.fromJson(e));
  }
}
