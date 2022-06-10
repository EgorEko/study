import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:study/app_theme_extended.dart';

import 'app_routes.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, this.initialRoute = '/'}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppThemeExtended(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(
              secondary: Colors.deepOrangeAccent,
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 12, color: Colors.white),
            )),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        //locale: Locale('ar', ''),
        themeMode: ThemeMode.dark,
        onGenerateRoute: onGenerateAppRoute,
        routes: appRoutes,
        initialRoute: initialRoute,
      ),
    );
  }
}
