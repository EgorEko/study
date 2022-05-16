import 'package:flutter/cupertino.dart';
import 'package:study/services/api_service.dart';

class UsersViewModel extends ChangeNotifier {
  final ApiService _apiService;

  UsersViewModel(this._apiService);

  Future<void> load() async {
    final users = await _apiService.getUsers(perPage: 20, since: 30);
    debugPrint('UsersViewModel: load() -> ${users.length}');
    debugPrint('UsersViewModel: load() -> ${users.last.id}');
  }
}
