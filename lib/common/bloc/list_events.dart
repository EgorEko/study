import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object?> get props => [];
}

class RefreshListEvent extends ListEvent {

  const RefreshListEvent();
}

class LoadMoreListEvent extends ListEvent {
  const LoadMoreListEvent();
}

class ReloadListEvent extends ListEvent {
  const ReloadListEvent();
}

class SearchListEvent extends ListEvent {
  final String term;

  const SearchListEvent(this.term);

    @override
  List<Object?> get props => [term];
}
