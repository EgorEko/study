class IssueDTO {
  factory IssueDTO.fromNumber(int number) {
    return IssueDTO._(number, '', null);
  }

  IssueDTO._(this.number, this.title, this.body);

  factory IssueDTO.fromJson(Map<String, dynamic> json) {
    return IssueDTO._(json['number'], json['title'], json['body']);
  }
  final String title;
  final int number;
  final String? body;
}
