import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/counter_repository.dart';
import 'services/api/api_service.dart';
import 'services/navigation_service.dart';

import 'dummy_utils.dart';
import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: dummyApiService),
        Provider<CounterRepository>(create: (_) => dummyCounterRepository),
        Provider<NavigationService>(create: (_) => NavigationService()),
      ],
      child: const MyApp(
        initialRoute: '/',
      ),
    ),
  );
}
