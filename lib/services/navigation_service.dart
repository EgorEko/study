import 'package:flutter/material.dart';
import 'package:study/services/api/responses/issue_dto.dart';

import '../app_routes_names.dart';
import '../pages/issues/issues_view_model.dart';

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

  void openNewIssue(BuildContext context) {
    _pushNamed<IssueDTO?>(context, newIssueRouteName);
  }

  void openEditIssue(BuildContext context, IssueModel issue) {
    _pushNamed<IssueDTO?>(context, editIssueRouteName, arguments: issue);
  }

  void openSearch(BuildContext context) {
    _pushNamed<IssueDTO?>(context, searchRouteName);
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
