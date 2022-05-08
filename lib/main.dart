import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';
import 'title_service.dart';

void main() {
  //final service = TitleServiceNew();

  runApp(Provider<TitleService>(
      create: (context) => TitleServiceNew(), child: const MyApp()));
  //runApp(ServiceLocator(titleService: service, child: const MyApp()));
}
