part of 'issues_bloc.dart';

class LoadedIssuesState extends LoadedListState<IssueModel> {
  final int page;

  LoadedIssuesState._(List<IssueModel> items,
      {this.page = 1, bool hasMore = true})
      : super(items, hasMore: hasMore);
}
