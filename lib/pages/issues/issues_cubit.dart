import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../services/api/api_service.dart';
import 'issues_view_model.dart';

abstract class IssuesState extends Equatable {
  const IssuesState();
  @override
  List<Object> get props => [];

  void loadMore() {}
}

class UninitializedIssuesState extends IssuesState {
  const UninitializedIssuesState._();
}

class LoadingIssuesState extends IssuesState {
  const LoadingIssuesState._();
}

class LoadedIssuesState extends IssuesState {
  final List<IssueModel> items;
  final int page;
  final bool moreAvailable;

  const LoadedIssuesState._(this.items,
      {this.page = 1, this.moreAvailable = true});

  @override
  List<Object> get props => [items];
}

class EmptyIssuesState extends IssuesState {
  const EmptyIssuesState._();
}

class FailedIssuesState extends IssuesState {
  final String message;

  const FailedIssuesState._(this.message);

  @override
  List<Object> get props => [message];
}

const _issuesPerPage = 15;

class LoadIssuesEvent {
  final int page;

  LoadIssuesEvent({this.page = 1});
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class IssuesCubit extends Bloc<LoadIssuesEvent, IssuesState> {
  final ApiService _apiService;

  IssuesCubit(this._apiService) : super(const UninitializedIssuesState._()) {
    on<LoadIssuesEvent>(_onIssuesFetched,
        transformer: throttleDroppable(const Duration(microseconds: 200)));
  }

  Future<void> _onIssuesFetched(
    LoadIssuesEvent event,
    Emitter<IssuesState> emit,
  ) async {
    if (state is UninitializedIssuesState) {
      //load
      emit(const LoadingIssuesState._());

      try {
        final issues = await _load(1);

        if (issues.isNotEmpty) {
          emit(LoadedIssuesState._(issues,
              moreAvailable: issues.length != _issuesPerPage));
        } else {
          emit(const EmptyIssuesState._());
        }
      } catch (e) {
        emit(FailedIssuesState._(e.toString()));
      }
    } else if (event.page == 1 &&
        (state is LoadedIssuesState ||
            state is FailedIssuesState ||
            state is EmptyIssuesState)) {
      try {
        final issues = await _load(1);

        if (issues.isNotEmpty) {
          emit(LoadedIssuesState._(issues,
              moreAvailable: issues.length != _issuesPerPage));
        } else {
          emit(const EmptyIssuesState._());
        }
      } catch (e) {}
    } else if (event.page > 1 && state is LoadedIssuesState) {
      final currentState = state;
      if (currentState is LoadedIssuesState) {
        if (currentState.moreAvailable) {
          final page = currentState.page + 1;

          final issues = await _load(page);
          emit(LoadedIssuesState._([...currentState.items, ...issues],
              page: page, moreAvailable: issues.length != _issuesPerPage));
        }
      }
    }
  }

  Future<void> load() async {
    add(LoadIssuesEvent());
  }

  Future<void> refresh() async {
    add(LoadIssuesEvent());
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is LoadedIssuesState) {
      if (currentState.moreAvailable) {
        final page = currentState.page + 1;

        add(LoadIssuesEvent(page: page));
      }
    }
  }

  Future<List<IssueModel>> _load(int page) async {
    final result = await _apiService.getIssues(
        owner: 'EgorEko', repo: 'study', page: page, perPage: _issuesPerPage);

    final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();
    return issues;
  }
}
