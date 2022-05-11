import 'package:flutter/material.dart';

class IncrementService extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }
}
