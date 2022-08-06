import 'package:flutter/material.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

import '../../styles/colors.dart';
import '../../utils/routers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                   customTextField(
                  hint: 'Enter your first name',
                  title: 'First Name',
                  controller: _firstName,
                ),
                   customTextField(
                  hint: 'Enter your last name',
                  title: 'Last Name',
                  controller: _lastName,
                ),
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
                  text: 'Create Account',
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
                      page: const LoginPage(),
                    );
                  },
                  child: const Text(
                    'Login instead?',
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