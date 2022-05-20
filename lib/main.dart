import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/dummy_api_service.dart';
import 'package:study/pages/home/home_page_view_model.dart';
import 'package:study/pages/issues/issues_view_model.dart';
import 'package:study/repositories/counter_repository.dart';
import 'package:study/services/api/api_service.dart';
import 'package:study/services/increment_service.dart';

import 'my_app.dart';
import 'title_service.dart';

void main() {
  final service = TitleService();
  var counterRepository = CounterRepository();
  var incrementService = IncrementService(counterRepository, step: 2);
  final homeViewModel = HomePageViewModel(incrementService);

  const currentUserToken = String.fromEnvironment('GITHUB_USER_TOKEN');
  //'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'
  final apiService = ApiService('https://api.github.com', currentUserToken);
  final usersViewModel = IssuesViewModel(dummyApiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: homeViewModel),
        ChangeNotifierProvider.value(value: usersViewModel),
        Provider<TitleService>.value(value: service),
      ],
      child: const MyApp(
        initialRoute: '/',
      ),
    ),
  );
  //runApp(Provider<TitleService>(
  //    create: (context) => TitleServiceNew(), child: const MyApp()));
  //runApp(ServiceLocator(titleService: service, child: const MyApp()));
}
