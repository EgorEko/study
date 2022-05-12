import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<HomePageViewModel>(context).currentValueText;

    return Text(
      counter,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
