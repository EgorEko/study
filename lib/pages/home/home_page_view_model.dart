import 'package:flutter/material.dart';
import 'package:study/services/increment_service.dart';

class HomePageViewModel extends ChangeNotifier {
  final IncrementService _incrementService;

  HomePageViewModel(this._incrementService);

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
