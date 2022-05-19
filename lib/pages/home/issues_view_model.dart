import 'package:flutter/cupertino.dart';
import 'package:study/services/api/api_service.dart';
import 'package:study/services/api/responses/issue_dto.dart';

class IssuesViewModel extends ChangeNotifier {
  final ApiService _apiService;
  List<IssueDTO>? _issues;

  IssuesViewModel(this._apiService);

  List<IssueDTO> get issues => _issues ?? [];

  bool get isLoading => _issues == null;

  Future<void> load() async {
    final users = await _apiService.getUsers(perPage: 20, since: 30);
    debugPrint('$runtimeType: load() -> users count ${users.length}');
    debugPrint('$runtimeType: load() -> last user in page ${users.last.id}');
    _issues = await _apiService.getIssues(owner: 'EgorEko', repo: 'study');
    notifyListeners();
  }
}
