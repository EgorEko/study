import 'package:flutter/material.dart';

import '../../app_injector.dart';
import 'issues_page.dart';

class IssuesPageBuilder extends StatelessWidget {
  const IssuesPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    context.issuesBloc.load();
    return const IssuesPage();
  }
}
