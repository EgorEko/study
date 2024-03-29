import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/issues/bloc/issues_bloc.dart';
import 'pages/issues/issues_view_model.dart';
import 'pages/search/bloc/search_bloc.dart';
import 'repositories/counter_repository.dart';
import 'services/api/api_service.dart';
import 'services/navigation_service.dart';
import 'title_service.dart';

extension AppInjector on BuildContext {
  TitleService get titleService =>
      Provider.of<TitleService>(this, listen: false);

  ApiService get apiService => Provider.of<ApiService>(this, listen: false);

  CounterRepository get counterRepository =>
      Provider.of<CounterRepository>(this, listen: false);

  NavigationService get navigationService =>
      Provider.of<NavigationService>(this, listen: false);

  IssuesViewModel get issuesViewModel =>
      Provider.of<IssuesViewModel>(this, listen: false);

  IssuesBloc get issuesBloc => Provider.of<IssuesBloc>(this, listen: false);

  SearchBloc get searchBloc => Provider.of<SearchBloc>(this, listen: false);
}
