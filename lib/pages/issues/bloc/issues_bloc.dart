import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../common/bloc/list_bloc.dart';
import '../../../common/bloc/list_events.dart';
import '../../../common/bloc/list_states.dart';
import '../../../services/api/api_service.dart';
import '../issues_view_model.dart';

part 'issues_state.dart';

part 'issues_events.dart';

//TODO: create, edit, delete

class IssuesBloc extends ListBloc<IssueModel> {
  final ApiService _apiService;
  final Map<int, DateTime> _deletedIssues = {};
  final Map<int, IssueModel> _pendingIssues = {};

  IssuesBloc(this._apiService) : super() {
    on<CloseIssueListEvent>(_close);
    on<CreateIssueListEvent>(_create);
  }

  @override
  LoadedListState<IssueModel> onCreateLoadedState(
      LoadedListState<IssueModel> state, List<IssueModel> items) {
    if (state is LoadedIssuesState) {
      return LoadedIssuesState._([...state.items, ...items],
          page: state.page + 1, hasMore: items.length != itemsButch);
    }
    if (state is InitialLoadedListState<IssueModel>) {
      return LoadedIssuesState._([...state.items, ...items],
          page: 2, hasMore: items.length != itemsButch);
    }
    return state;
  }

  @override
  Future<List<IssueModel>> loadData() {
    return _load(1).then((value) => [...value, ..._pendingIssues.values]);
  }

  @override
  Future<List<IssueModel>> loadMoreData(LoadedListState<IssueModel> state) {
    if (state is LoadedIssuesState) {
      return _load(state.page + 1);
    }
    if (state is InitialLoadedListState<IssueModel>) {
      return _load(2);
    }
    return Future.value(<IssueModel>[]);
  }

  Future<List<IssueModel>> _load(int page) async {
    final result = await _apiService.getIssues(
      owner: 'EgorEko',
      repo: 'study',
      page: page,
      perPage: itemsButch,
    );
    final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();
    final now = DateTime.now();
    _deletedIssues
        .removeWhere((key, value) => now.difference(value).inSeconds > 10);
    final filtered =
        issues.whereNot((e) => _deletedIssues.keys.contains(e.number)).toList();
    return filtered;
  }

  Future<void> _close(
      CloseIssueListEvent event, Emitter<ListState> emitter) async {
    _deletedIssues[event.data.number] = DateTime.now();
    final currentState = state;
    if (currentState is LoadedIssuesState) {
      final items =
          currentState.items.whereNot((e) => e.number == event.data.number);

      emitter(LoadedIssuesState._([...items],
          page: currentState.page, hasMore: currentState.hasMore));
    }
    /*await _apiService.closeIssue(
        owner: 'EgorEko',
        repo: 'study',
        issue: IssueDTO.fromNumber(event.data.number));*/
  }

  Future<void> _create(
      CreateIssueListEvent event, Emitter<ListState> emitter) async {
    final newIssue = IssueModel(0, event.title, event.body);
    _pendingIssues.putIfAbsent(newIssue.number, () => newIssue);

    final currentState = state;
    if (currentState is LoadedIssuesState) {
      final items = currentState.items;

      emitter(LoadedIssuesState._([...items, newIssue],
          page: currentState.page, hasMore: currentState.hasMore));
    }
  }
  /*final result = await _apiService.createIssue(
        owner: 'EgorEko',
        repo: 'study', title: event.title, body: event.body);
    _issues ??= <IssueModel>[];
    _issues?.insert(0, IssueModel.fromIssueDTO(result));*/

  void deleteIssue(IssueModel data) {
    add(CloseIssueListEvent._(data));
  }

  void createIssue({required String title, String? body}) {
    add(CreateIssueListEvent._(title, body));
  }
}
