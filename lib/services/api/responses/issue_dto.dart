class IssueDTO {
  final String title;
  final int number;
  final String? body;

  IssueDTO._(this.number, this.title, this.body);

  factory IssueDTO.fromJson(Map<String, dynamic> json) {
    return IssueDTO._(json['number'], json['title'], json['body']);
  }

  factory IssueDTO.fromNumber(int number) {
    return IssueDTO._(number, '', null);
  }
}
