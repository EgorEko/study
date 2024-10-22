import 'dart:collection';

import 'package:equatable/equatable.dart';

abstract class RefreshableState {}

abstract class ListState extends Equatable {
  const ListState._();

  @override
  List<Object?> get props => [];
}

class UninitializedListState extends ListState {
  const UninitializedListState() : super._();
}

class LoadingListState extends ListState {
  const LoadingListState() : super._();
}

abstract class LoadedListState<T> extends ListState
    implements RefreshableState {
  LoadedListState(List<T> items, {this.hasMore = true})
      : _items = UnmodifiableListView(items),
        super._();
  final UnmodifiableListView<T> _items;
  final bool hasMore;

  List<T> get items => _items.toList();

  @override
  List<Object?> get props => [items, hasMore];
}

class EmptyListState extends ListState implements RefreshableState {
  const EmptyListState() : super._();
}

class FailedListState extends ListState implements RefreshableState {
  const FailedListState(this.message) : super._();
  final String message;

  @override
  List<Object?> get props => [message];
}

class InitialLoadedListState<T> extends LoadedListState<T> {
  InitialLoadedListState(super.items, {super.hasMore});
}
