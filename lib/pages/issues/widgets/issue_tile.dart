import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:study/app_strings.dart';

import '../issues_view_model.dart';

class IssueTile extends StatelessWidget {
  final IssueModel data;

  const IssueTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(data.title),
        onTap: () => context.navigationService.openIssue(context, data.number),
        subtitle:
            Text(data.body ?? '', maxLines: 3, overflow: TextOverflow.ellipsis),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
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
        ]),
      ),
    );
  }
}
