import 'package:flutter/material.dart';
import 'package:study/pages/edit_issue/edit_issue_page.dart';
import 'package:study/pages/issues/issues_view_model.dart';

class EditIssuePageBuilder extends StatelessWidget {
  const EditIssuePageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final issue = ModalRoute.of(context)!.settings.arguments as IssueModel;
    return EditIssuePage(issue: issue);
  }
}
