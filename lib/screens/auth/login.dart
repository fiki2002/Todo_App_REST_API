import 'package:flutter/material.dart';
import 'package:todo_app/screens/auth/register.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

import '../../styles/colors.dart';
import '../../utils/routers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                customTextField(
                  hint: 'Enter your valid email address',
                  title: 'Email',
                  controller: _email,
                ),
                customTextField(
                  hint: 'Enter your secured password',
                  title: 'Password',
                  controller: _password,
                ),
                customButton(
                  text: 'Login',
                  tap: () {},
                  context: context,
                  status: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    PageNavigator(ctext: context).nextPage(
                      page: const RegisterPage(),
                    );
                  },
                  child: const Text(
                    'Create an account here',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
