import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:provider/provider.dart';
import 'package:study/pages/new_issue/new_issue_page.dart';
import 'package:study/pages/new_issue/new_issue_page_builder.dart';
import 'package:study/services/api/responses/issue_dto.dart';

import 'app_routes_names.dart';
import 'pages/edit_issue/edit_issue_page_builder.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_page_view_model.dart';
import 'pages/issue_details/issue_details_page.dart';
import 'pages/issues/issues_page_builder.dart';
import 'services/increment_service.dart';
import 'services/navigation_service.dart';
import 'title_service.dart';

Route? onGenerateAppRoute(RouteSettings settings) {
  if (settings.name == issueRouteName) {
    final args = settings.arguments as IssueDetailsArguments;

    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return IssueDetailsPage(
          issueNumber: args.number,
        );
      },
    );
  }
  if (settings.name == newIssueRouteName) {
    return MaterialPageRoute<IssueDTO?>(
      settings: settings,
      builder: (context) {
        return const NewIssuesPageBuilder();
      },
    );
  }
  if (settings.name == editIssueRouteName) {
    return MaterialPageRoute<IssueDTO?>(
      settings: settings,
      builder: (context) {
        return const EditIssuePageBuilder();
      },
    );
  }
  return null;
}

final Map<String, WidgetBuilder> appRoutes = {
  homeRouteName: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomePageViewModel(
              IncrementService(context.counterRepository, step: 2),
            ),
          ),
          Provider(
            create: (_) => TitleService(),
          )
        ],
        child: const HomePage(),
      ),
  newIssueRouteName: (context) => const NewIssuePage(),
  issuesRouteName: (context) => const IssuesPageBuilder(),
};
