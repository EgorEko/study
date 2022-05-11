import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/increment_service.dart';

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
            Consumer<IncrementService>(
              builder: (_, service, child) {
                final counter = service.value;
                return Row(
                  children: [
                    child!,
                    Text(
                      '$counter',
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
            Provider.of<IncrementService>(context, listen: false).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<IncrementService>(context).value;

    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
