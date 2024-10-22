import 'package:flutter/material.dart';
import '../../../app_injector.dart';
import '../../../app_strings.dart';

import '../issues_view_model.dart';

class IssueTile extends StatelessWidget {
  const IssueTile({required this.data, super.key});

  final IssueModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.title),
        onTap: () => context.navigationService.openIssue(context, data.number),
        subtitle:
            Text(data.body ?? '', maxLines: 3, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                context.navigationService.openEditIssue(context, data);
              },
              child: Text(context.localizations.editTitle),
            ),
            TextButton(
              onPressed: () {
                context.issuesBloc.deleteIssue(data);
              },
              child: Text(context.localizations.deleteTitle),
            ),
          ],
        ),
      ),
    );
  }
}
