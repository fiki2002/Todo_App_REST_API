import 'package:flutter/material.dart';
import 'package:todo_app/provider/database/db_provider.dart';

import '../../utils/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            onPressed: () {
              showMessage(message: 'You have logged out', context: context);
              DatabaseProvider().logOut(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
