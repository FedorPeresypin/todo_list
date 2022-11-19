import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/entity/task.dart';
import 'package:todo_list/business_logic/viewmodels/task_viewmodel.dart';

import '../../../business_logic/bloc/task_bloc/task_bloc.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is TaskEmptyState) {
          return const Scaffold(
            body: Center(
              child: Text('Task list is empty'),
            ),
          );
        }
        if (state is TaskErrorState) {
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
        if (state is TaskLoadedState) {
          return const TaskScreenWidget();
        }
        throw Exception('Что-то пошло не так...');
      },
    );
  }
}

class TaskScreenWidget extends StatelessWidget {
  const TaskScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: const _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/groups/tasks/form'),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget();
  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskViewModel>().group.tasks;
    if (tasks == null) {
      return const Center(
        child: Text('Задач пока нет'),
      );
    } else {
      return Theme(
        data: ThemeData(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) => _TaskListRowWidget(
            key: Key(index.toString()),
            task: tasks[index],
          ),
          itemCount: tasks.length,
        ),
      );
    }
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final Task task;
  const _TaskListRowWidget({Key? key, required this.task}) : super(key: key);

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
      onDismissed: (direction) => context.read<TaskViewModel>().deleteTask(task),
      child: Card(
        child: ListTile(title: Text(task.name), trailing: Checkbox(value: task.isDone, onChanged: (value) => context.read<TaskViewModel>().changeTask(task))),
      ),
    );
  }
}
