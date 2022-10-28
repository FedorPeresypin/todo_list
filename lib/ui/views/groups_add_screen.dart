import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/viewmodels/groups_viewmodel.dart';

class GroupsAddScreen extends StatelessWidget {
  const GroupsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New group'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: GroupTextWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () {
          context.read<GroupsViewModel>().saveGroup(context);
        },
      ),
    );
  }
}

class GroupTextWidget extends StatelessWidget {
  const GroupTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Name group',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => context.read<GroupsViewModel>().groupName = value,
      onEditingComplete: () => context.read<GroupsViewModel>().saveGroup(context),
    );
  }
}
