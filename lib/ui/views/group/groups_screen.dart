import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/group_event.dart';
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
          if (state is GroupLoadedState) {
            return _GroupListWidget(state: state);
          }
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
  final GroupLoadedState state;
  const _GroupListWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        itemBuilder: (context, index) => _GroupListRowWidget(
          key: Key('$index'),
          index: index,
          state: state,
        ),
        itemCount: state.groups.length,
        onReorder: (oldIndex, newIndex) => context.read<GroupsViewModel>().reorderGroup(oldIndex, newIndex),
      ),
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int index;
  final GroupLoadedState state;
  const _GroupListRowWidget({Key? key, required this.index, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      onDismissed: (direction) => context.read<GroupBloc>().add(GroupDeleteEvent(indexGroup: index)),
      child: Card(
        child: ListTile(
          title: Text(state.groups[index].name),
          onTap: () {
            context.read<TaskViewModel>().showTasks(context, group: state.groups[index]);
          },
        ),
      ),
    );
  }
}
