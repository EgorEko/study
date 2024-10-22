import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_injector.dart';
import '../../../app_strings.dart';
import '../../../common/widgets/failed_list_widget.dart';

import '../../../common/bloc/list_states.dart';
import '../../../common/widgets/empty_list_widget.dart';
import '../../issues/issues_view_model.dart';
import '../../issues/widgets/issue_tile.dart';
import '../bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.searchTitle),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              context.searchBloc.search(value);
            },
            decoration: const InputDecoration(
              hintText: 'Type to start search',
            ),
          ),
          Expanded(
            child: _IssuesBodyContainer(
              bodyBuilder: (context, state, refreshIndicatorKey) {
                if (state is EmptyListState) {
                  return EmptyListWidget(
                    title: 'No issues found',
                    icon: Icons.edit,
                    onAction: () {},
                  );
                } else if (state is FailedListState) {
                  return FailedListWidget(
                    onRetry: () => refreshIndicatorKey.currentState?.show(),
                    message: state.message,
                  );
                } else if (state is LoadedListState<IssueModel>) {
                  final items = state.items;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      if (index > items.length - 5) {
                        context.searchBloc.loadMore();
                      }
                      final item = items[index];
                      return IssueTile(data: item);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IssuesBodyContainer extends StatelessWidget {
  _IssuesBodyContainer({required this.bodyBuilder});
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final Function(BuildContext, ListState, GlobalKey<RefreshIndicatorState>)
      bodyBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, ListState>(
      builder: (context, state) {
        if (state is RefreshableState) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              context.issuesBloc.refresh();
              await Future.delayed(const Duration(milliseconds: 300));
            },
            child: bodyBuilder(context, state, _refreshIndicatorKey),
          );
        }
        if (state is UninitializedListState) {
          return EmptyListWidget(
            title: 'Type at least three symbols',
            icon: Icons.edit,
            onAction: () {},
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
