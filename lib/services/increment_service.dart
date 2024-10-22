import '../repositories/counter_repository.dart';

class IncrementService {
  IncrementService(this._counterRepository, {this.step = 1});
  final CounterRepository _counterRepository;

  final int step;
  int _value = 0;

  int get currentValue => _value;

  Future<void> load() async {
    final savedValue = await _counterRepository.read();
    _value = savedValue;
  }

  void increment() {
    _value += step;

    _counterRepository.save(_value);
  }
}
