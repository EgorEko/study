import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';

class HomePage extends StatelessWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

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
            TextButton(
                onPressed: () => {Navigator.pushNamed(context, '/issues')},
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
