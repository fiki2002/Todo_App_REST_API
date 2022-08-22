import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/taskProvider/add_task_provider.dart';
import 'package:todo_app/utils/snackbar.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

import '../../widgets/custom_button.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _title = TextEditingController();
  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Tasks'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    customTextField(
                      title: 'Title',
                      controller: _title,
                      hint: 'What do you want to do',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AddTaskProvider>(
                        builder: (context, addTask, child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (addTask.getResponse != '') {
                          showMessage(
                            message: addTask.getResponse,
                            context: context,
                          );
                          addTask.clear();
                        }
                      });

                      return customButton(
                        status: addTask.getStatus,
                        context: context,
                        tap: () {
                          if (_title.text.isEmpty) {
                            showMessage(
                                context: context, message: 'Fill in title');
                          } else {
                            addTask.addTask(
                              title: _title.text.trim(),
                            );
                          }
                        },
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
