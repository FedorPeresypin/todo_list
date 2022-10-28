import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/viewmodels/groups_viewmodel.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups todolists'),
        centerTitle: true,
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/groups/form'),
      ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget();

  @override
  Widget build(BuildContext context) {
    final groupsCount = context.watch<GroupsViewModel>().groups.length;
    return ListView.builder(
      itemBuilder: (context, index) => _GroupListRowWidget(indexInList: index),
      itemCount: groupsCount,
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({required this.indexInList});

  @override
  Widget build(BuildContext context) {
    final group = context.watch<GroupsViewModel>().groups[indexInList];
    return Card(
      child: ListTile(
        title: Text(group.name),
        subtitle: Text(group.indexGroup.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => context.read<GroupsViewModel>().deleteGroup(indexInList),
        ),
      ),
    );
  }
}
