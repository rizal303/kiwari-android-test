import 'package:localstorage/localstorage.dart';

class FlutterLocalStorage {
  final _userStorage = new LocalStorage('user');
  final String _email = "email";

  static final FlutterLocalStorage _singleton =
      new FlutterLocalStorage._internal();

  factory FlutterLocalStorage() {
    return _singleton;
  }

  FlutterLocalStorage._internal();

  Future<void> saveUserStorage(String email) async {
    if (await _userStorage.ready) {
      _userStorage.setItem(_email, email);
    }
  }

  Future<void> clear() async {
    return await _userStorage.clear();
  }

  LocalStorage getUserStorage() {
    return _userStorage;
  }

  String getEmail() {
    return _userStorage.getItem(_email);
  }
}
