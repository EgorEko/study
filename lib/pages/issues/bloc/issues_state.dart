part of 'issues_bloc.dart';

class LoadedIssuesState extends LoadedListState<IssueModel> {
  final int page;

  LoadedIssuesState._(super.items,
      {this.page = 1, super.hasMore});
}
