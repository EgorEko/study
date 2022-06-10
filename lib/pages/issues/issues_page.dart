import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study/app_injector.dart';
import 'package:provider/provider.dart';
import 'package:study/app_strings.dart';
import 'package:study/pages/issues/issues_cubit.dart';

import 'issues_view_model.dart';

class IssuesPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  IssuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<IssuesCubit>(context, listen: false).load();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.issuesTitle),
      ),
      body: buildBlocBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigationService.openNewIssue(context);
        },
        tooltip: 'New Issue',
        child: const Icon(Icons.add),
      ),
    );
  }

  BlocBuilder<IssuesCubit, IssuesState> buildBlocBody() {
    return BlocBuilder<IssuesCubit, IssuesState>(builder: (context, state) {
      if (state is EmptyIssuesState) {
        return withIndicator(
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No issues! Create one tostart play'),
                  IconButton(
                      onPressed: () {
                        _refreshIndicatorKey.currentState?.show();
                      },
                      icon: Icon(Icons.refresh)),
                ],
              ),
            ),
            context);
      } else if (state is FailedIssuesState) {
        return withIndicator(
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Oops!!! ${state.message}'),
                  IconButton(
                      onPressed: () async {
                        _refreshIndicatorKey.currentState?.show();
                      },
                      icon: Icon(Icons.refresh)),
                ],
              ),
            ),
            context);
      } else if (state is LoadedIssuesState) {
        final items = state.items;
        return withIndicator(
            ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.title),
                      onTap: () => context.navigationService
                          .openIssue(context, item.number),
                      subtitle: Text(item.body ?? '',
                          maxLines: 3, overflow: TextOverflow.ellipsis),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        TextButton(
                          onPressed: () {
                            context.navigationService
                                .openEditIssue(context, item);
                          },
                          child: Text(context.localizations.editTitle),
                        ),
                        TextButton(
                          onPressed: () {
                            context.issuesViewModel.deleteIssue(item);
                          },
                          child: Text(context.localizations.deleteTitle),
                        ),
                      ]),
                    ),
                  );
                }),
            context);
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget withIndicator(Widget widget, BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () async {
          await Provider.of<IssuesCubit>(context, listen: false).refresh();
        },
        child: widget);
  }

  Consumer<IssuesViewModel> buildConsumerBody(BuildContext context) {
    return Consumer<IssuesViewModel>(
      builder: (_, issuesVM, child) {
        if (issuesVM.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = issuesVM.issues;
        return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.title),
                  onTap: () =>
                      context.navigationService.openIssue(context, item.number),
                  subtitle: Text(item.body ?? '',
                      maxLines: 3, overflow: TextOverflow.ellipsis),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    TextButton(
                      onPressed: () {
                        context.navigationService.openEditIssue(context, item);
                      },
                      child: Text(context.localizations.editTitle),
                    ),
                    TextButton(
                      onPressed: () {
                        context.issuesViewModel.deleteIssue(item);
                      },
                      child: Text(context.localizations.deleteTitle),
                    ),
                  ]),
                ),
              );
            });
      },
    );
  }
}
