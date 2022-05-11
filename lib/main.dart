import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/increment_service.dart';

import 'my_app.dart';
import 'title_service.dart';

void main() {
  final service = TitleService();
  final incrementService = IncrementService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: incrementService),
        Provider<TitleService>.value(value: service),
      ],
      child: const MyApp(),
    ),
  );
  //runApp(Provider<TitleService>(
  //    create: (context) => TitleServiceNew(), child: const MyApp()));
  //runApp(ServiceLocator(titleService: service, child: const MyApp()));
}
