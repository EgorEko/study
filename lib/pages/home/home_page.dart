import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_injector.dart';
import '../../app_theme_extended.dart';

import 'home_page_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(context.titleService.pageTitle)),
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
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Container(
              width: AppThemeExtended.of(context)!.containerWith,
              height: Theme.of(context).containerHeight,
              color: Colors.greenAccent,
              child: TextButton(
                onPressed: () => context.navigationService.openIssues(context),
                child: const Text('Issues'),
              ),
            ),
            Container(
              width: AppThemeExtended.of(context)!.containerWith,
              height: Theme.of(context).containerHeight,
              color: Colors.greenAccent,
              child: TextButton(
                onPressed: () => context.navigationService.openSearch(context),
                child: const Text('Search'),
              ),
            ),
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
