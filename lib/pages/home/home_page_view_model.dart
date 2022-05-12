import 'package:flutter/material.dart';
import 'package:study/services/increment_service.dart';

class HomePageViewModel extends ChangeNotifier {
  final IncrementService _incrementService;

  HomePageViewModel(this._incrementService);

  String get currentValueText => _incrementService.currentValue.toString();

  void initialize() {
    _incrementService.load();
  }

  void increment() {
    _incrementService.increment();
    notifyListeners();
  }
}
