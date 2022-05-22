import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/app_injector.dart';
import 'package:study/issues_routes_named.dart';
import 'package:study/pages/home/home_page_view_model.dart';
import 'package:study/pages/issues/issues_page_build.dart';
import 'package:study/services/increment_service.dart';
import 'package:study/title_service.dart';

import 'pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, this.initialRoute = '/'}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
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
        issuesRouteName: (context) => const IssuesPageBuilder()
      },
      initialRoute: initialRoute,
    );
  }
}
