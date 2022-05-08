import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'title_service.dart';

extension AppInjector on BuildContext {
  TitleService get titleService =>
      Provider.of<TitleService>(this, listen: false);
}
