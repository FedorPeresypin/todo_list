import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/viewmodels/groups_viewmodel.dart';

class GroupsAddScreen extends StatelessWidget {
  GroupsAddScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New group'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Name group',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          context.read<GroupsViewModel>().saveGroup(controller.text);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
