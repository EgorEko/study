import 'package:flutter/material.dart';
import 'edit_issue_page.dart';
import '../issues/issues_view_model.dart';

class EditIssuePageBuilder extends StatelessWidget {
  const EditIssuePageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final issue = ModalRoute.of(context)!.settings.arguments as IssueModel;
    return EditIssuePage(issue: issue);
  }
}
