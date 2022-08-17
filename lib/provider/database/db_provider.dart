import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  //create an instance of the shared preference
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  //creating a setter
  String _token = '';

  String _userId = '';

  String get token => _token;

  String get userId => _userId;

  //To save the token
  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  //To save the userId
  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('id', id);
  }

  //To get the token
  Future<String> getToken() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  //To get the userId
  Future<String> getUserId() async {
    SharedPreferences value = await _pref;
    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }
}
