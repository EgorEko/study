import 'package:flutter/cupertino.dart';
import '../../services/api/api_service.dart';
import '../../services/api/responses/issue_dto.dart';

class IssuesViewModel extends ChangeNotifier {
  IssuesViewModel(this._apiService);
  final ApiService _apiService;
  List<IssueModel>? _issues;

  List<IssueModel> get issues => _issues ?? [];

  bool get isLoading => _issues == null;

  @override
  void addListener(VoidCallback listener) {
    super.addListener((listener));
    load();
  }

  Future<void> load() async {
    _issues ??= (await _apiService.getIssues(owner: 'EgorEko', repo: 'study'))
        .map((e) => IssueModel.fromIssueDTO(e))
        .toList();
    notifyListeners();
  }

  Future<void> createNewIssue({required String title, String? body}) async {
    final result = await _apiService.createIssue(
      owner: 'EgorEko',
      repo: 'study',
      title: title,
      body: body,
    );

    _issues ??= <IssueModel>[];
    _issues?.insert(0, IssueModel.fromIssueDTO(result));

    notifyListeners();
  }

  void deleteIssue(IssueModel item) {
    _issues?.remove(item);
    notifyListeners();
    _apiService.closeIssue(
      owner: 'EgorEko',
      repo: 'study',
      issue: IssueDTO.fromNumber(item.number),
    );
  }

  void updateIssue(IssueModel issue, {required String title, String? body}) {
    final editIndex = _issues?.indexWhere((e) => e.number == issue.number);
    _issues?[editIndex!] = IssueModel(issue.number, title, body);

    notifyListeners();
    _apiService.updateIssue(
      owner: 'EgorEko',
      repo: 'study',
      issue: IssueDTO.fromNumber(issue.number),
      title: title,
      body: body,
    );
  }
}

class IssueModel {
  IssueModel(this.number, this.title, this.body);

  factory IssueModel.fromIssueDTO(IssueDTO issue) {
    return IssueModel(issue.number, issue.title, issue.body);
  }
  final String title;
  final int number;
  final String? body;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueModel &&
          runtimeType == other.runtimeType &&
          number == other.number;

  @override
  int get hashCode => number.hashCode;
}
