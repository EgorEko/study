class TitleService {
  String get appTitle => 'Flutter Demo';

  String get pageTitle => 'Flutter Demo Home Page';
}

class TitleServiceNew extends TitleService {
  @override
  String get appTitle => 'Oops Demo';

  @override
  String get pageTitle => 'Oops Demo Home Page_';
}
