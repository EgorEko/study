import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/app_injector.dart';
import 'package:study/issues_routes_named.dart';

import 'home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.titleService.pageTitle),
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
            TextButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, issuesRouteName)},
                child: const Text('Issues')),
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
