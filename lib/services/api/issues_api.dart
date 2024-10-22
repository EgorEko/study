part of 'api_service.dart';

extension IssuesApi on ApiService {
  Future<List<IssueDTO>> getIssues({
    required String owner,
    required String repo,
    int perPage = 15,
    int? page,
  }) async {
    final url = _baseUri.replace(
      path: '/repos/$owner/$repo/issues',
      queryParameters: <String, dynamic>{
        'per_page': perPage.toString(),
        if (page != null) 'page': page.toString(),
      },
    );
    final response = await _client.get(url, headers: _defaultHeaders);
    return _parseList(response, (e) => IssueDTO.fromJson(e));
  }

  Future<IssueDTO> createIssue({
    required String owner,
    required String repo,
    required String title,
    String? body,
  }) async {
    final url = _baseUri.replace(path: '/repos/$owner/$repo/issues');
    final requestBody = {
      'title': title,
      if (body != null) 'body': body,
    };
    final response = await _client.post(
      url,
      body: jsonEncode(requestBody),
      headers: _defaultHeaders,
    );
    return _parseObject(response, (e) => IssueDTO.fromJson(e));
  }

  Future<IssueDTO> closeIssue({
    required String owner,
    required String repo,
    required IssueDTO issue,
  }) async {
    final url =
        _baseUri.replace(path: '/repos/$owner/$repo/issues/${issue.number}');
    final requestBody = {'state': 'closed'};
    final response = await _client.patch(
      url,
      body: jsonEncode(requestBody),
      headers: _defaultHeaders,
    );
    return _parseObject(response, (e) => IssueDTO.fromJson(e));
  }

  Future<IssueDTO> updateIssue({
    required String owner,
    required String repo,
    required IssueDTO issue,
    required String title,
    String? body,
  }) async {
    final url =
        _baseUri.replace(path: '/repos/$owner/$repo/issues/${issue.number}');
    final requestBody = {
      'title': title,
      'body': body,
    };
    final response = await _client.patch(
      url,
      body: jsonEncode(requestBody),
      headers: _defaultHeaders,
    );
    return _parseObject(response, (e) => IssueDTO.fromJson(e));
  }

  Future<IssueDTO> getIssue(
    int issue, {
    required String owner,
    required String repo,
  }) async {
    final url = _baseUri.replace(
      path: '/repos/$owner/$repo/issues/$issue',
    );
    final response = await _client.get(url, headers: _defaultHeaders);
    return _parseObject(response, (e) => IssueDTO.fromJson(e));
  }

  Future<List<IssueDTO>> search({
    required String term,
    int perPage = 15,
    int? page,
  }) async {
    return [];
  }

  Future<List<IssueDTO>> searchIssues({
    required String query,
    int perPage = 15,
    int? page,
  }) async {
    final url = _baseUri.replace(
      path: '/search/issues',
      queryParameters: <String, dynamic>{
        'q': query,
        'per_page': perPage.toString(),
        if (page != null) 'page': page.toString(),
      },
    );
    final response = await _client.get(url, headers: _defaultHeaders);
    return _parseObject(response, (e) => SearchIssuesDTO.fromJson(e)).items;
  }
}
