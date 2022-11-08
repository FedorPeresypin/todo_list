import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/viewmodels/groups_viewmodel.dart';
import 'package:todo_list/business_logic/viewmodels/task_viewmodel.dart';

import '../../../business_logic/bloc/group_bloc.dart';
import '../../../business_logic/bloc/group_state.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups todolists'),
        centerTitle: true,
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GroupEmptyState) {
            return const Center(
              child: Text('Task list is empty'),
            );
          }
          if (state is GroupLoadedState) {
            log(state.groups.toString());
            return const _GroupListWidget();
          }
          if (state is GroupErrorState) {
            return const Center(
              child: Text('Error'),
            );
          }
          throw Exception('Что-то пошло не так...');
        },
      ),
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
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        itemBuilder: (context, index) => _GroupListRowWidget(key: Key('$index'), indexInList: index),
        itemCount: groupsCount,
        onReorder: (oldIndex, newIndex) => context.read<GroupsViewModel>().reorderGroup(oldIndex, newIndex),
      ),
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<GroupsViewModel>().groups[indexInList];
    return Dismissible(
      key: UniqueKey(),
      secondaryBackground: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 50,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      background: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) async => await context.read<GroupsViewModel>().deleteGroup(indexInList),
      child: Card(
        child: ListTile(
          title: Text(group.name),
          onTap: () {
            context.read<TaskViewModel>().showTasks(context, group: group);
          },
        ),
      ),
    );
  }
}
