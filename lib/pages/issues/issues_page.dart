import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'issues_view_model.dart';

import '../../app_injector.dart';
import '../../app_strings.dart';
import '../../common/bloc/list_states.dart';
import '../../common/widgets/empty_list_widget.dart';
import '../../common/widgets/failed_list_widget.dart';
import 'bloc/issues_bloc.dart';
import 'widgets/issue_tile.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.issuesTitle),
      ),
      body: _IssuesBodyContainer(
        bodyBuilder: (context, state, refreshIndicatorKey) {
          if (state is EmptyListState) {
            return EmptyListWidget(
              title: 'No issues! Create one to start play',
              icon: Icons.add,
              onAction: () => context.navigationService.openNewIssue(context),
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
                  context.issuesBloc.loadMore();
                }
                final item = items[index];
                return IssueTile(data: item);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigationService.openNewIssue(context);
        },
        tooltip: 'New Issue',
        child: const Icon(Icons.add),
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
    return BlocBuilder<IssuesBloc, ListState>(
      builder: (context, state) {
        if (state is RefreshableState) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              context.issuesBloc.refresh();
            },
            child: bodyBuilder(context, state, _refreshIndicatorKey),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
