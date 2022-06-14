import 'package:flutter/material.dart';

import '../../app_injector.dart';
import 'issues_page.dart';

class IssuesPageBuilder extends StatelessWidget {
  const IssuesPageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.issuesCubit.load();
    return const IssuesPage();
  }
}
