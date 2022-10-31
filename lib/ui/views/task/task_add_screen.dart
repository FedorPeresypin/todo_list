import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/entity/task.dart';
import 'package:todo_list/business_logic/viewmodels/task_viewmodel.dart';

class TaskAddScreen extends StatelessWidget {
  TaskAddScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New task'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Name task',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          context.read<TaskViewModel>().addTask(Task(name: controller.text));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
