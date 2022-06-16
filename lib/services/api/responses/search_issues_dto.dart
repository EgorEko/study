import 'package:study/services/api/responses/issue_dto.dart';

class SearchIssuesDTO {
  final List<IssueDTO> items;

  SearchIssuesDTO._(this.items);

  factory SearchIssuesDTO.fromJson(Map<String, dynamic> json) {
    final jsonItem = json['items'] as List<dynamic>;
    final items = jsonItem.map((e) => IssueDTO.fromJson(e)).toList();
    return SearchIssuesDTO._(items);
  }
}
