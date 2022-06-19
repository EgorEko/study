part of 'issues_bloc.dart';

class CloseIssueListEvent extends ListEvent {
  final IssueModel data;

  const CloseIssueListEvent._(this.data);

  @override
  List<Object?> get props => [data];
}

class CreateIssueListEvent extends ListEvent {
  final String title;
  final String? body;

  const CreateIssueListEvent._(this.title, this.body);

  @override
  List<Object?> get props => [title, body];
}
