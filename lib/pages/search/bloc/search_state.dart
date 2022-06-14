part of 'search_bloc.dart';

class FoundedIssuesState extends LoadedListState<IssueModel> {
  final int page;
  final String term;

  const FoundedIssuesState._(List<IssueModel> items, this.term,
      {this.page = 1, bool hasMore = true})
      : super(items, hasMore: hasMore);
}
