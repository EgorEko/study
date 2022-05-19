part of 'api_service.dart';

extension IssuesApi on ApiService {
  Future<List<IssueDTO>> getIssues(
      {required String owner,
      required String repo,
      int perPage = 15,
      int? page}) async {
    final url = _baseUri.replace(
        path: '/repos/$owner/$repo/issues',
        queryParameters: <String, dynamic>{
          'per_page': perPage.toString(),
          if (page != null) 'page': page.toString()
        });
    final response = await _client.get(url, headers: _defaultHeaders);
    return _parseList(response, (e) => IssueDTO.fromJson(e));
  }

  Future<IssueDTO> getIssue(int issue,
      {required String owner, required String repo}) async {
    final url = _baseUri.replace(
      path: '/repos/$owner/$repo/issues/$issue',
    );
    final response = await _client.get(url, headers: _defaultHeaders);
    return _parseObject(response, (e) => IssueDTO.fromJson(e));
  }
}
