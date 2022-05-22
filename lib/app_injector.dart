import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/repositories/counter_repository.dart';
import 'package:study/services/api/api_service.dart';

import 'title_service.dart';

extension AppInjector on BuildContext {
  TitleService get titleService =>
      Provider.of<TitleService>(this, listen: false);

  ApiService get apiService => Provider.of<ApiService>(this, listen: false);
  CounterRepository get counterRepository =>
      Provider.of<CounterRepository>(this, listen: false);
}
