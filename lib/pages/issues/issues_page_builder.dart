import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:provider/provider.dart';

import 'issues_page.dart';
import 'issues_view_model.dart';

class IssuesPageBuilder extends StatelessWidget {
  const IssuesPageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => IssuesViewModel(context.apiService),
      )
    ], child: const IssuesPage());
  }
}
