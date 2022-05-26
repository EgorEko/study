import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:provider/provider.dart';

import 'issues_view_model.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issues'),
      ),
      body: Consumer<IssuesViewModel>(
        builder: (_, issuesVM, child) {
          if (issuesVM.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = issuesVM.issues;
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.title),
                  onTap: () =>
                      context.navigationService.openIssue(context, item.number),
                  subtitle: Text(item.body ?? '',
                      maxLines: 3, overflow: TextOverflow.ellipsis),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    TextButton(
                        onPressed: () {
                          context.navigationService
                              .openEditIssue(context, item);
                        },
                        child: const Text('Edit')),
                    TextButton(
                        onPressed: () {
                          context.issuesViewModel.deleteIssue(item);
                        },
                        child: const Text('Delete')),
                  ]),
                );
              });
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
