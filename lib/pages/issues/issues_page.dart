import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/pages/issues/issues_view_model.dart';

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
                  subtitle: Text(item.body ?? '',
                      maxLines: 3, overflow: TextOverflow.ellipsis),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'New Issue',
        child: const Icon(Icons.add),
      ),
    );
  }
}