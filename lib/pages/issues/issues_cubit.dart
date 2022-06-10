import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/pages/issues/issues_view_model.dart';
import 'package:study/services/api/api_service.dart';

abstract class IssuesState extends Equatable {
  const IssuesState();
  @override
  List<Object> get props => [];
}

class UninitializedIssuesState extends IssuesState {
  const UninitializedIssuesState._();
}

class LoadingIssuesState extends IssuesState {
  const LoadingIssuesState._();
}

class LoadedIssuesState extends IssuesState {
  final List<IssueModel> items;

  const LoadedIssuesState._(this.items);

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

class IssuesCubit extends Cubit<IssuesState> {
  final ApiService _apiService;
  IssuesCubit(this._apiService) : super(const UninitializedIssuesState._());

  Future<void> load() async {
    if (state is UninitializedIssuesState) {
      emit(const LoadingIssuesState._());

      try {
        final result =
            await _apiService.getIssues(owner: 'EgorEko', repo: 'study');

        final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();

        if (issues.isNotEmpty) {
          emit(LoadedIssuesState._(issues));
        } else {
          emit(const EmptyIssuesState._());
        }
      } catch (e) {
        emit(FailedIssuesState._(e.toString()));
      }
    }
  }

  Future<void> refresh() async {
    try {
      final result =
          await _apiService.getIssues(owner: 'EgorEko', repo: 'study');

      final issues = result.map((e) => IssueModel.fromIssueDTO(e)).toList();

      if (issues.isNotEmpty) {
        emit(LoadedIssuesState._(issues));
      } else {
        emit(const EmptyIssuesState._());
      }
    } catch (e) {
      emit(FailedIssuesState._(e.toString()));
    }
  }
}
