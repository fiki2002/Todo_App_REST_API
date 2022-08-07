import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/authProvider/auth_provider.dart';
import 'package:todo_app/screens/auth/register.dart';
import 'package:todo_app/widgets/custom_button.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

import '../../utils/routers.dart';
import '../../utils/snackbar.dart';

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
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
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
                  Consumer<AuthenticationProvider>(builder: (
                    context,
                    auth,
                    child,
                  ) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (auth.resMessage != '') {
                        showMessage(message: auth.resMessage, context: context);

                        auth.clear();
                      }
                    });
                    return customButton(
                      text: 'Login',
                      tap: () {
                        if (_email.text.isEmpty || _password.text.isEmpty) {
                          showMessage(
                            message: 'All fields are required',
                            context: context,
                          );
                        } else {
                          auth.loginUser(
                            email: _email.text.trim(),
                            password: _password.text.trim(),
                            context: context,
                          );
                        }
                      },
                      context: context,
                      status: auth.isLoading,
                    );
                  }),
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
          ),
        ],
      ),
    );
  }
}
