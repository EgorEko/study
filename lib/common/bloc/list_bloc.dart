import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'list_events.dart';
import 'list_states.dart';

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

abstract class ListBloc<T> extends Bloc<ListEvent, ListState> {
  ListBloc() : super(const UninitializedListState()) {
    on<RefreshListEvent>(_onRefresh);
    on<ReloadListEvent>(_onInitialLoad);
    on<LoadMoreListEvent>(
      _onLoadMore,
      transformer: throttleDroppable(const Duration(milliseconds: 200)),
    );
  }

  @protected
  int get itemsButch => 15;

  Future<void> _onInitialLoad(
    ReloadListEvent event,
    Emitter<ListState> emit,
  ) async {
    if (state is UninitializedListState && state is! LoadingListState) {
      emit(const LoadingListState());
      try {
        await onLoaded(emit);
      } catch (e) {
        emit(FailedListState(e.toString()));
      }
    }
  }

  Future<void> _onRefresh(
    RefreshListEvent event,
    Emitter<ListState> emit,
  ) async {
    final currentState = state;
    if (currentState is RefreshableState) {
      try {
        await onRefreshed(emit);
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> _onLoadMore(
    LoadMoreListEvent event,
    Emitter<ListState> emit,
  ) async {
    final currentState = state;
    if (currentState is LoadedListState<T>) {
      if (currentState.hasMore) {
        await onMoreLoaded(currentState, emit);
      }
    }
  }

  @protected
  Future<void> onMoreLoaded(
    LoadedListState<T> state,
    Emitter<ListState> emit,
  ) async {
    final issues = await loadMoreData(state);

    emit(onCreateLoadedState(state, issues));
  }

  @protected
  Future<void> onRefreshed(Emitter<ListState> emit) => onLoaded(emit);

  @protected
  Future<void> onLoaded(Emitter<ListState> emit) async {
    final items = await loadData();

    if (items.isNotEmpty) {
      final initialState =
          InitialLoadedListState(items, hasMore: items.length != itemsButch);
      emit(initialState);
    } else {
      emit(const EmptyListState());
    }
  }

  @protected
  Future<List<T>> loadData();

  @protected
  Future<List<T>> loadMoreData(LoadedListState<T> state);

  @protected
  LoadedListState<T> onCreateLoadedState(
    LoadedListState<T> state,
    List<T> items,
  );

  void load() {
    add(const ReloadListEvent());
  }

  void refresh() {
    add(const RefreshListEvent('issues'));
  }

  void loadMore() {
    add(const LoadMoreListEvent());
  }
}
