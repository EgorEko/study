import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'pages/issues/issues_view_model.dart';
import 'repositories/counter_repository.dart';
import 'services/api/api_service.dart';
import 'services/navigation_service.dart';
import 'my_app.dart';
import 'pages/issues/bloc/issues_cubit.dart';

void main() {
  const currentUserToken = String.fromEnvironment('GITHUB_USER_TOKEN');
  final apiService = ApiService('https://api.github.com', currentUserToken);

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>.value(value: apiService),
        Provider<CounterRepository>(
          create: (_) => CounterRepository(),
        ),
        Provider<NavigationService>(
          create: (_) => NavigationService(),
        ),
        ChangeNotifierProvider(create: (_) => IssuesViewModel(apiService)),
        BlocProvider(create: (_) => IssuesBloc(apiService))
      ],
      child: const MyApp(
        initialRoute: '/',
      ),
    ),
  );
}
