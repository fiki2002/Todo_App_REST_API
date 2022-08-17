import 'package:flutter/material.dart';
import 'package:todo_app/provider/database/db_provider.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/screens/taskPage/local_widget/task_view_container.dart';

import '../../styles/colors.dart';
import '../../utils/routers.dart';
import '../../utils/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List tasks = ['hi'];
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
      body: Container(
          padding: const EdgeInsets.all(20),
          child: tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Todo List is empty',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          PageNavigator(ctext: context)
                              .nextPage(page: const LoginPage());
                        },
                        child: Text(
                          'Create a task',
                          style: TextStyle(fontSize: 18, color: grey),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: List.generate(
                    10,
                    (index) => TaskField(
                      initial: '${index + 1}',
                      title: 'I wanna fuck someone so bad',
                      subtitle: 'Fuck',
                      isCompleted: false,
                      taskId: 'Fk',
                    ),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        mini: true,
        child: const Icon(Icons.add),
        tooltip: 'Create Tasks',
      ),
    );
  }
}
