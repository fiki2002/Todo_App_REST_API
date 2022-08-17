import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_textfield.dart';

import '../../widgets/custom_button.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key, required this.taskId, required this.title})
      : super(key: key);
  final String taskId;
  final String title;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final TextEditingController _title = TextEditingController();
  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _title.text = widget.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tasks Details'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
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
                    customButton(
                      status: false,
                      text: 'Update',
                      context: context,
                      tap: () {},
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
