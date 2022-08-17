import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/authProvider/auth_provider.dart';
import 'package:todo_app/provider/database/db_provider.dart';
import 'package:todo_app/splash.dart';
import 'package:todo_app/styles/colors.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
          primaryColor: primaryColor,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
