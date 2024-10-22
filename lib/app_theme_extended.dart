import 'package:flutter/material.dart';

class AppThemeExtended extends InheritedWidget {
  const AppThemeExtended({
    required super.child,
    super.key,
    this.containerWith = 100,
  });
  final double containerWith;

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
