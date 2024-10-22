part of 'issues_bloc.dart';

class CloseIssueListEvent extends ListEvent {
  const CloseIssueListEvent._(this.data);
  final IssueModel data;

  @override
  List<Object?> get props => [data];
}

class CreateIssueListEvent extends ListEvent {
  const CreateIssueListEvent._(this.title, this.body);
  final String title;
  final String? body;

  @override
  List<Object?> get props => [title, body];
}
