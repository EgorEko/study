part of 'issues_cubit.dart';

abstract class LoadIssuesEvent extends Equatable {
  const LoadIssuesEvent._();

  @override
  List<Object> get props => [];
}

class ReLoadIssuesEvent extends LoadIssuesEvent {
  const ReLoadIssuesEvent._() : super._();
}

class RefreshIssuesEvent extends LoadIssuesEvent {
  const RefreshIssuesEvent._() : super._();
}

class LoadMoreIssuesEvent extends LoadIssuesEvent {
  const LoadMoreIssuesEvent._() : super._();
}
