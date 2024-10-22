part of 'search_bloc.dart';

class FoundedIssuesState extends LoadedListState<IssueModel> {
  FoundedIssuesState._(
    super.items,
    this.term, {
    this.page = 1,
  });
  final int page;
  final String term;
}
