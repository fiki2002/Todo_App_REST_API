import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/provider/database/db_provider.dart';

import '../../constants/url.dart';
import '../../screens/taskPage/home_page.dart';
import '../../screens/auth/login.dart';
import '../../utils/routers.dart';

class AuthenticationProvider extends ChangeNotifier {
//Base Url
  final requestBaseUrl = AppUrl.baseUrl;

//create a setter to know when our data changes
  bool _isLoading = false;
  String _resMessage = ''; //a request to the API

  //getter: we listen to it in the app
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/";

    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
    };
    if (kDebugMode) {
      print(body);
    }

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);

        if (kDebugMode) {
          print(res);
        }
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();

        PageNavigator(ctext: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];

        if (kDebugMode) {
          print(res);
        }
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      if (kDebugMode) {
        print(":::: $e");
      }
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "$requestBaseUrl/users/login";

    final body = {
      "email": email,
      "password": password,
    };
    if (kDebugMode) {
      print(body);
    }

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);

        if (kDebugMode) {
          print(res);
        }
        _isLoading = false;
        _resMessage = "Login Successful!";
        notifyListeners();
        //if the status code is successful that is 200
        //save users data and then navigate to homepage
        final userId = res['user']['id'];
        final token = res['authToken'];

        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
        PageNavigator(ctext: context).nextPageOnly(page: const HomePage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];
        if (kDebugMode) {
          print(res);
        }
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again";
      notifyListeners();

      if (kDebugMode) {
        print(":::: $e");
      }
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
