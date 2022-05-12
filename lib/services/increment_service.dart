import 'package:study/repositories/counter_repository.dart';

class IncrementService {
  final CounterRepository _counterRepository;

  final int step;
  int _value = 0;

  IncrementService(this._counterRepository, {this.step = 1});

  int get currentValue => _value;

  void load() async {
    final savedValue = await _counterRepository.read();
    _value = savedValue;
  }

  void increment() {
    _value += step;

    _counterRepository.save(_value);
  }
}
