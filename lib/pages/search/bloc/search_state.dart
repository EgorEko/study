part of 'search_bloc.dart';

class FoundedIssuesState extends LoadedListState<IssueModel> {
  final int page;
  final String term;

  FoundedIssuesState._(super.items, this.term,
      {this.page = 1,});
}
