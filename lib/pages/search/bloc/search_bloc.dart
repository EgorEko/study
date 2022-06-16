import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stream_transform/stream_transform.dart';

import '../../../common/bloc/list_bloc.dart';
import '../../../common/bloc/list_events.dart';
import '../../../common/bloc/list_state.dart';
import '../../../services/api/api_service.dart';
import '../../issues/issues_view_model.dart';

part 'search_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration).distinct(), mapper);
  };
}

class SearchBloc extends ListBloc<IssueModel> {
  final ApiService _apiService;

  SearchBloc(this._apiService) : super() {
    on<SearchListEvent>(_search,
        transformer: debounceDroppable(const Duration(milliseconds: 300)));
  }

  Future<void> _search(SearchListEvent event, Emitter<ListState> emit) async {
    if (event.term.length >= 3 && state is UninitializedListState) {
      emit(const LoadingListState());
      final items = await _doSearch(event.term, 2);
      if (items.isNotEmpty) {
        emit(FoundedIssuesState._(items, event.term));
      } else {
        emit(const EmptyListState());
      }
    } else if (event.term.length < 3) {
      emit(const UninitializedListState());
    } else if (event.term.length >= 3) {
      final items = await _doSearch(event.term, 2);
      if (items.isNotEmpty) {
        emit(FoundedIssuesState._(items, event.term));
      } else {
        emit(const EmptyListState());
      }
    }
  }

  @override
  Future<List<IssueModel>> loadData() {
    // TODO: implement loadData
    throw UnimplementedError();
  }

  @override
  Future<List<IssueModel>> loadMoreData(LoadedListState<IssueModel> state) {
    if (state is FoundedIssuesState) {
      return _doSearch(state.term, state.page + 1);
    }
    return Future.value(<IssueModel>[]);
  }

  @override
  LoadedListState<IssueModel> onCreateLoadedState(
      LoadedListState<IssueModel> state, List<IssueModel> items) {
    if (state is FoundedIssuesState) {
      return FoundedIssuesState._([...state.items, ...items], state.term,
          page: state.page + 1);
    }
    return state;
  }

  void search(String term) {
    add(SearchListEvent(term));
  }

  Future<List<IssueModel>> _doSearch(String term, int page) async {
    final result = await _apiService.searchIssues(
      query: term,
      page: page,
      perPage: itemsButch,
    );
    final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();
    return issues;
  }
}
