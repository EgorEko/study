import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/pages/home/home_page_view_model.dart';
import 'package:study/pages/home/users_view_model.dart';
import 'package:study/repositories/counter_repository.dart';
import 'package:study/services/api_service.dart';
import 'package:study/services/increment_service.dart';

import 'my_app.dart';
import 'title_service.dart';

void main() {
  final service = TitleService();
  var counterRepository = CounterRepository();
  var incrementService = IncrementService(counterRepository, step: 2);
  final homeViewModel = HomePageViewModel(incrementService);

  final apiService = ApiService('https://api.github.com');
  final usersViewModel = UsersViewModel(apiService);
  usersViewModel.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: homeViewModel),
        ChangeNotifierProvider(create: (context) => UsersViewModel(apiService)),
        Provider<TitleService>.value(value: service),
      ],
      child: const MyApp(),
    ),
  );
  //runApp(Provider<TitleService>(
  //    create: (context) => TitleServiceNew(), child: const MyApp()));
  //runApp(ServiceLocator(titleService: service, child: const MyApp()));
}
