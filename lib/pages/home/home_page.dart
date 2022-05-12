import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_widget.dart';
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
                return Row(
                  children: [
                    child!,
                    Text(
                      counter,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                );
              },
              child: Image.asset(
                'images/download.jpeg',
                width: 400,
                height: 400,
              ),
            ),
            const CounterText(),
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
