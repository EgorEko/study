import 'package:flutter/material.dart';

class AppThemeExtended extends InheritedWidget {
  final double containerWith;

  const AppThemeExtended({
    super.key,
    this.containerWith = 100,
    required super.child,
  });

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
