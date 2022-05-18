import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/pages/home/issues_view_model.dart';

import 'home_page_view_model.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer<HomePageViewModel>(
              builder: (_, service, child) {
                final counter = service.currentValueText;
                return Text(
                  counter,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Expanded(
              child: Consumer<IssuesViewModel>(
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<HomePageViewModel>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
