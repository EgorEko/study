part of 'issues_cubit.dart';

abstract class RefreshableState {}

abstract class IssuesState extends Equatable {
  const IssuesState();

  @override
  List<Object> get props => [];
}

class UninitializedIssuesState extends IssuesState {
  const UninitializedIssuesState._();
}

class LoadingIssuesState extends IssuesState {
  const LoadingIssuesState._();
}

class LoadedIssuesState extends IssuesState implements RefreshableState {
  final List<IssueModel> items;
  final int page;
  final bool moreAvailable;

  const LoadedIssuesState._(this.items,
      {this.page = 1, this.moreAvailable = true});

  @override
  List<Object> get props => [items];
}

class EmptyIssuesState extends IssuesState implements RefreshableState {
  const EmptyIssuesState._();
}

class FailedIssuesState extends IssuesState implements RefreshableState {
  final String message;

  const FailedIssuesState._(this.message);

  @override
  List<Object> get props => [message];
}
