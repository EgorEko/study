import 'package:flutter/material.dart';
import '../../services/increment_service.dart';

class HomePageViewModel extends ChangeNotifier {
  HomePageViewModel(this._incrementService);
  final IncrementService _incrementService;

  String get currentValueText => _incrementService.currentValue.toString();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _incrementService.load().whenComplete(() => notifyListeners());
  }

  void increment() {
    _incrementService.increment();
    notifyListeners();
  }
}
