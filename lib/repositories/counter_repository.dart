import 'package:shared_preferences/shared_preferences.dart';

const _kCounerSharedKey = 'current_counter';

class CounterRepository {
  Future<void> save(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kCounerSharedKey, value);
  }

  Future<int> read() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getInt(_kCounerSharedKey);
    return result ?? 0;
  }
}
