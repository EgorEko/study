import 'package:flutter/material.dart';

class AppThemeExtended extends InheritedWidget {
  final double containerWith;

  const AppThemeExtended({
    Key? key,
    this.containerWith = 100,
    required Widget child,
  }) : super(key: key, child: child);

  static AppThemeExtended? of(BuildContext context) {
    final AppThemeExtended? result =
        context.dependOnInheritedWidgetOfExactType<AppThemeExtended>();
    return result;
  }

  @override
  bool updateShouldNotify(covariant AppThemeExtended oldWidget) =>
      oldWidget.containerWith != containerWith;
}

extension AppTheme on ThemeData {
  double get containerHeight => 100;
}
