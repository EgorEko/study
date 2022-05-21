import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dummy_api_service.dart';
import 'my_app.dart';
import 'pages/home/home_page_view_model.dart';
import 'pages/issues/issues_view_model.dart';
import 'repositories/counter_repository.dart';
import 'services/increment_service.dart';
import 'title_service.dart';

void main() {
  final service = TitleService();
  var counterRepository = CounterRepository();
  var incrementService = IncrementService(counterRepository, step: 2);
  final homeViewModel = HomePageViewModel(incrementService);
  final usersViewModel = IssuesViewModel(dummyApiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: homeViewModel),
        ChangeNotifierProvider.value(value: usersViewModel),
        Provider<TitleService>.value(value: service),
        //create_dummy_conf
      ],
      child: const MyApp(
        initialRoute: '/',
      ),
    ),
  );
}
