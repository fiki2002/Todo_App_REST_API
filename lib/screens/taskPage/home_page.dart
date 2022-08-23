import 'package:flutter/material.dart';
import 'package:todo_app/provider/database/db_provider.dart';
import 'package:todo_app/provider/taskProvider/get_task_service.dart';
import 'package:todo_app/screens/taskPage/add_task_page.dart';
import 'package:todo_app/screens/taskPage/local_widget/task_view_container.dart';

import '../../model/task_model.dart';
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

  // void initState() {
  //   super.initState();
  //   GetUserTask().getTask();
  // }

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
        child: FutureBuilder<TaskModel>(
          future: GetUserTask().getTask(),
          builder: ((context, snapshot) {
            print(snapshot);
            if (snapshot.hasError) {
              return const Center(child: Text('Error Occured'));
            } else if (snapshot.hasData) {
              if (snapshot.data!.tasks == null) {
                return Center(
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
                              .nextPage(page: const CreateTaskPage());
                        },
                        child: Text(
                          'Create a task',
                          style: TextStyle(fontSize: 18, color: grey),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView(
                  children: List.generate(
                    snapshot.data!.tasks!.length,
                    (index) {
                      final data = snapshot.data!.tasks![index];
                      return TaskField(
                        initial: '${index + 1}',
                        title: data.title,
                        subtitle: data.startTime.toString(),
                        isCompleted: false,
                        taskId: data.id.toString(),
                      );
                    },
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => PageNavigator(ctext: context).nextPage(
          page: const CreateTaskPage(),
        ),
        mini: true,
        child: const Icon(Icons.add),
        tooltip: 'Create Tasks',
      ),
    );
  }
}
