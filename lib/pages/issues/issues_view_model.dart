import 'package:flutter/cupertino.dart';
import 'package:study/services/api/api_service.dart';
import 'package:study/services/api/responses/issue_dto.dart';

class IssuesViewModel extends ChangeNotifier {
  final ApiService _apiService;
  List<IssueDTO>? _issues;

  IssuesViewModel(this._apiService);

  List<IssueDTO> get issues => _issues ?? [];

  bool get isLoading => _issues == null;

  @override
  void addListener(VoidCallback listener) {
    super.addListener((listener));
    load();
  }

  Future<void> load() async {
    _issues ??= await _apiService.getIssues(owner: 'EgorEko', repo: 'study');
    notifyListeners();
  }
}
