import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study/pages/issues/issues_cubit.dart';
import 'package:study/pages/issues/issues_view_model.dart';
import 'package:study/repositories/counter_repository.dart';
import 'package:study/services/api/api_service.dart';
import 'package:study/services/navigation_service.dart';

import 'my_app.dart';

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
        BlocProvider(create: (_) => IssuesCubit(apiService))
      ],
      child: const MyApp(
        initialRoute: '/',
      ),
    ),
  );
}
