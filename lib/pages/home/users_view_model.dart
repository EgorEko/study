import 'package:flutter/cupertino.dart';
import 'package:study/services/api_service.dart';

class UsersViewModel extends ChangeNotifier {
  final ApiService _apiService;

  UsersViewModel(this._apiService);

  Future<void> load() async {
    final users = await _apiService.getUsers();
    print(users.length);
  }
}
