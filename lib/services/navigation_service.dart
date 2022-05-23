import 'package:flutter/material.dart';

import '../app_routes_names.dart';

class NavigationService {
  void openHome(BuildContext context) {
    _pushNamed(context, homeRouteName);
  }

  void openIssues(BuildContext context) {
    _pushNamed(context, issuesRouteName);
  }

  void openIssue(BuildContext context, int number) {
    _pushNamed(context, issueRouteName,
        arguments: IssueDetailsArguments._(number));
  }

  Future<T?> _pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    debugPrint('$runtimeType: $routeName ${arguments ?? ''}');
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}

class IssueDetailsArguments {
  final int number;

  IssueDetailsArguments._(this.number);

  @override
  String toString() {
    return 'IssueDetailsArguments {number: $number}';
  }
}
