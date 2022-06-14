import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_injector.dart';
import '../../app_strings.dart';
import '../../common/bloc/list_state.dart';
import 'bloc/issues_bloc.dart';
import 'widgets/empty_issues_widget.dart';
import 'widgets/failed_issues_widget.dart';
import 'widgets/issue_tile.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.issuesTitle),
      ),
      body: _IssuesBodyContainer(
        bodyBuilder: (context, state, refreshIndicatorKey) {
          if (state is EmptyListState) {
            return EmtyIssuesWidget(
                onRefresh: () => refreshIndicatorKey.currentState?.show());
          } else if (state is FailedListState) {
            return FailedIssuesWidget(
                onRetry: () => refreshIndicatorKey.currentState?.show(),
                message: state.message);
          } else if (state is LoadedIssuesState) {
            final items = state.items;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  if (index > items.length - 5) {
                    context.issuesCubit.loadMore();
                  }
                  final item = items[index];
                  return IssueTile(data: item);
                });
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final Function(BuildContext, ListState, GlobalKey<RefreshIndicatorState>)
      bodyBuilder;

  _IssuesBodyContainer({Key? key, required this.bodyBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesBloc, ListState>(builder: (context, state) {
      if (state is RefreshableState) {
        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            context.issuesCubit.refresh();
          },
          child: bodyBuilder(context, state, _refreshIndicatorKey),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
