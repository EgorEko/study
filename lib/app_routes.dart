import 'package:flutter/material.dart';
import 'package:study/app_injector.dart';
import 'package:provider/provider.dart';

import 'app_routes_names.dart';
import 'pages/home/home_page.dart';
import 'pages/home/home_page_view_model.dart';
import 'pages/issue_details/issue_details_page.dart';
import 'pages/issues/issues_page_build.dart';
import 'services/increment_service.dart';
import 'services/navigation_service.dart';
import 'title_service.dart';

RouteFactory onGenerateAppRoute = (RouteSettings settings) {
  if (settings.name == issueRouteName) {
    final args = settings.arguments as IssueDetailsArguments;

    return MaterialPageRoute(
      builder: (context) {
        return IssueDetailsPage(
          issueNumber: args.number,
        );
      },
    );
  }
};

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
  issuesRouteName: (context) => const IssuesPageBuilder(),
};
