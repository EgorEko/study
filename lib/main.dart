import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/repositories/counter_repository.dart';
import 'package:study/services/api/api_service.dart';

import 'my_app.dart';

void main() {
  const currentUserToken = String.fromEnvironment('GITHUB_USER_TOKEN');

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (_) => ApiService('https://api.github.com', currentUserToken),
        ),
        Provider<CounterRepository>(
          create: (_) => CounterRepository(),
        ),
      ],
      child: const MyApp(
        initialRoute: '/',
      ),
    ),
  );
}
