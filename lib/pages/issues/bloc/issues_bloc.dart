import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:study/common/bloc/list_events.dart';

import '../../../common/bloc/list_state.dart';
import '../../../services/api/api_service.dart';
import '../issues_view_model.dart';

part 'issues_state.dart';

const _issuesPerPage = 15;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class IssuesBloc extends Bloc<ListEvent, ListState> {
  final ApiService _apiService;

  IssuesBloc(this._apiService) : super(const UninitializedListState()) {
    on<RefreshListEvent>(_onRefresh);
    on<ReloadListEvent>(_onInitialLoad);
    on<LoadMoreListEvent>(_onLoadMore,
        transformer: throttleDroppable(const Duration(microseconds: 200)));
  }

  Future<void> _onInitialLoad(
    ReloadListEvent event,
    Emitter<ListState> emit,
  ) async {
    if (state is UninitializedListState && state is! LoadingListState) {
      emit(const LoadingListState());
      try {
        final issues = await _load(1);

        if (issues.isNotEmpty) {
          emit(LoadedIssuesState._([...issues, ...issues, ...issues],
              hasMore: issues.length != _issuesPerPage));
        } else {
          emit(const EmptyListState());
        }
      } catch (e) {
        emit(FailedListState(e.toString()));
      }
    }
  }

  Future<void> _onRefresh(
    RefreshListEvent event,
    Emitter<ListState> emit,
  ) async {
    if (state is RefreshableState) {
      try {
        final issues = await _load(1);

        if (issues.isNotEmpty) {
          emit(LoadedIssuesState._(issues,
              hasMore: issues.length != _issuesPerPage));
        } else {
          emit(const EmptyListState());
        }
      } catch (e) {}
    }
  }

  Future<void> _onLoadMore(
    LoadMoreListEvent event,
    Emitter<ListState> emit,
  ) async {
    final currentState = state;
    if (currentState is LoadedIssuesState) {
      if (currentState.hasMore) {
        final page = currentState.page + 1;

        final issues = await _load(page);

        emit(LoadedIssuesState._([...currentState.items, ...issues],
            page: page, hasMore: issues.length != _issuesPerPage));
      }
    }
  }

  void load() {
    add(const ReloadListEvent());
  }

  void refresh() {
    add(const RefreshListEvent());
  }

  void loadMore() {
    add(const LoadMoreListEvent());
  }

  Future<List<IssueModel>> _load(int page) async {
    final result = await _apiService.getIssues(
        owner: 'EgorEko', repo: 'study', page: page, perPage: _issuesPerPage);

    final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();
    return issues;
  }
}
