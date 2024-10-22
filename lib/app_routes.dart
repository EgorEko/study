import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_injector.dart';
import 'pages/new_issue/new_issue_page_builder.dart';
import 'services/api/responses/issue_dto.dart';
import 'app_routes_names.dart';
import 'pages/edit_issue/edit_issue_page_builder.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_page_view_model.dart';
import 'pages/issue_details/issue_details_page.dart';
import 'pages/issues/issues_page_builder.dart';
import 'pages/search/search_page/search_page_builder.dart';
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
  if (settings.name == searchRouteName) {
    return MaterialPageRoute<IssueDTO?>(
      settings: settings,
      builder: (context) {
        return const SearchPageBuilder();
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
          ),
        ],
        child: const HomePage(),
      ),
  issuesRouteName: (context) => const IssuesPageBuilder(),
};
