
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../screens/taskPage/home_page.dart';
import '../../utils/routers.dart';
import '../database/db_provider.dart';

class DeleteTaskProvider extends ChangeNotifier {
  final url = AppUrl.baseUrl;

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  
  void deleteTask({String? taskId, BuildContext? context}) async {
    final token = await DatabaseProvider().getToken();
    _status = true;
    notifyListeners();

    final _url = "$url/tasks/$taskId";

    final result = await http
        .delete(Uri.parse(_url), headers: {'Authorization': "Bearer $token"});

    print(result.statusCode);

    if (result.statusCode == 200 || result.statusCode == 201) {
      final res = result.body;
      print(res);
      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
      PageNavigator(ctext: context).nextPageOnly(page: const HomePage());
    } else {
      final res = result.body;
      print(res);
      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}