import 'package:flutter/material.dart';
import 'package:todo_app/provider/database/db_provider.dart';
import 'package:todo_app/screens/taskPage/home_page.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '' /*That is user not logged in */){
      PageNavigator(ctext: context).nextPageOnly(page: const LoginPage());

        }else {
          PageNavigator(ctext: context).nextPageOnly(page: const HomePage());

        }
      });
    });
  }
}
