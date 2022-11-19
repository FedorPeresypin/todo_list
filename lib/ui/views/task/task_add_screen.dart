import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../business_logic/bloc/task_bloc/task_bloc.dart';

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
          context.read<TaskBloc>().add(TaskAddEvent(name: controller.text));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
