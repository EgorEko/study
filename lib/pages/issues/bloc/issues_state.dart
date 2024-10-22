part of 'issues_bloc.dart';

class LoadedIssuesState extends LoadedListState<IssueModel> {
  LoadedIssuesState._(
    super.items, {
    this.page = 1,
    super.hasMore,
  });
  final int page;
}
