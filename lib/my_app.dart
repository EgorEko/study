import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/app_injector.dart';
import 'package:study/app_routes_names.dart';
import 'package:study/pages/home/home_page_view_model.dart';
import 'package:study/pages/issue_details/issue_details_page.dart';
import 'package:study/pages/issues/issues_page_build.dart';
import 'package:study/services/increment_service.dart';
import 'package:study/services/navigation_service.dart';
import 'package:study/title_service.dart';

import 'app_routes.dart';
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
      onGenerateRoute: onGenerateAppRoute,
      routes: appRoutes,
      initialRoute: initialRoute,
    );
  }
}
