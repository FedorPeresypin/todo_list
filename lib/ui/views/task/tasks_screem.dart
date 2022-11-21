import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/entity/task.dart';

import '../../../business_logic/bloc/task_bloc/task_bloc.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return Text('Группа');
          },
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TaskEmptyState) {
            return const Center(
              child: Text('Task list is empty'),
            );
          }
          if (state is TaskErrorState) {
            return const Center(
              child: Text('Error'),
            );
          }
          if (state is TaskLoadedState) {
            return _TaskListWidget(
              state: state,
            );
          }
          throw Exception('Что-то пошло не так...');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/groups/tasks/form'),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  final TaskLoadedState state;
  const _TaskListWidget({required this.state});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        itemBuilder: (context, index) => _TaskListRowWidget(
          key: ValueKey(index),
          task: state.taskList[index],
          index: index,
        ),
        itemCount: state.taskList.length,
        onReorder: (oldIndex, newIndex) => context.read<TaskBloc>().add(TaskReorderEvent(oldIndex: oldIndex, newIndex: newIndex)),
      ),
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final Task task;
  final int index;
  const _TaskListRowWidget({Key? key, required this.task, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(task),
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
          color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.check,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) => {
        context.read<TaskBloc>().add(TaskDeleteEvent(taskIndex: index)),
      },
      child: Card(
        child: ListTile(
          title: Text(task.name),
          trailing: Checkbox(
            value: task.isDone,
            onChanged: (value) => context.read<TaskBloc>().add(TaskChangeEvent(task: task)),
          ),
        ),
      ),
    );
  }
}
