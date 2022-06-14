import 'package:equatable/equatable.dart';

abstract class RefreshableState {}

abstract class ListState extends Equatable {
  const ListState._();

  @override
  List<Object> get props => [];
}

class UninitializedListState extends ListState {
  const UninitializedListState() : super._();
}

class LoadingListState extends ListState {
  const LoadingListState() : super._();
}

abstract class LoadedListState<T> extends ListState
    implements RefreshableState {
  final List<T> items;
  final bool hasMore;

  const LoadedListState(this.items, {this.hasMore = true}) : super._();

  @override
  List<Object> get props => [items];
}

class EmptyListState extends ListState implements RefreshableState {
  const EmptyListState() : super._();
}

class FailedListState extends ListState implements RefreshableState {
  final String message;

  const FailedListState(this.message) : super._();

  @override
  List<Object> get props => [message];
}
