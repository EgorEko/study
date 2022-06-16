import '../../../common/bloc/list_bloc.dart';
import '../../../common/bloc/list_state.dart';
import '../../../services/api/api_service.dart';
import '../issues_view_model.dart';

part 'issues_state.dart';

class IssuesBloc extends ListBloc<IssueModel> {
  final ApiService _apiService;

  IssuesBloc(this._apiService) : super();

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
    return _load(1);
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
    return issues;
  }
}
