import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_injector.dart';

import '../bloc/search_bloc.dart';
import 'search_page.dart';

class SearchPageBuilder extends StatelessWidget {
  const SearchPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    context.issuesBloc.load();
    return BlocProvider(
      create: (BuildContext context) {
        return SearchBloc(context.apiService);
      },
      child: const SearchPage(),
    );
  }
}
