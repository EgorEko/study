import 'package:flutter/material.dart';

import 'title_service.dart';

class ServiceLocator extends InheritedWidget {
  const ServiceLocator({
    required this.titleService,
    required super.child,
    super.key,
  });

  final TitleService titleService;

  static ServiceLocator? of(BuildContext context) {
    final ServiceLocator? result =
        context.dependOnInheritedWidgetOfExactType<ServiceLocator>();
    return result;
  }

  @override
  bool updateShouldNotify(ServiceLocator oldWidget) =>
      oldWidget.titleService != titleService;
}
