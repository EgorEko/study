import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../services/api/api_service.dart';
import '../issues_view_model.dart';

part 'issues_state.dart';
part 'issues_events.dart';

const _issuesPerPage = 15;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class IssuesBloc extends Bloc<LoadIssuesEvent, IssuesState> {
  final ApiService _apiService;

  IssuesBloc(this._apiService) : super(const UninitializedIssuesState._()) {
    on<RefreshIssuesEvent>(_onRefresh);
    on<ReLoadIssuesEvent>(_onInitialLoad);
    on<LoadMoreIssuesEvent>(_onLoadMore,
        transformer: throttleDroppable(const Duration(microseconds: 200)));
  }

  Future<void> _onInitialLoad(
    ReLoadIssuesEvent event,
    Emitter<IssuesState> emit,
  ) async {
    if (state is UninitializedIssuesState && state is! LoadedIssuesState) {
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
    }
  }

  Future<void> _onRefresh(
    RefreshIssuesEvent event,
    Emitter<IssuesState> emit,
  ) async {
    if (state is RefreshableState) {
      try {
        final issues = await _load(1);

        if (issues.isNotEmpty) {
          emit(LoadedIssuesState._(issues,
              moreAvailable: issues.length != _issuesPerPage));
        } else {
          emit(const EmptyIssuesState._());
        }
      } catch (e) {}
    }
  }

  Future<void> _onLoadMore(
    LoadMoreIssuesEvent event,
    Emitter<IssuesState> emit,
  ) async {
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

  load() {
    add(const ReLoadIssuesEvent._());
  }

  refresh() {
    add(const RefreshIssuesEvent._());
  }

  loadMore() {
    add(const LoadMoreIssuesEvent._());
  }

  Future<List<IssueModel>> _load(int page) async {
    final result = await _apiService.getIssues(
        owner: 'EgorEko', repo: 'study', page: page, perPage: _issuesPerPage);

    final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();
    return issues;
  }
}
