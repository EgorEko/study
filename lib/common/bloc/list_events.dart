import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object?> get props => [];
}

class RefreshListEvent extends ListEvent {
  const RefreshListEvent(this.tag);
  final String tag;
}

class LoadMoreListEvent extends ListEvent {
  const LoadMoreListEvent();
}

class ReloadListEvent extends ListEvent {
  const ReloadListEvent();
}

class SearchListEvent extends ListEvent {
  const SearchListEvent(this.term);
  final String term;

  @override
  List<Object?> get props => [term];
}
