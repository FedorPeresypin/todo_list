part of 'task_bloc.dart';

abstract class TaskState {}

class TaskInitializeState extends TaskState {}

class TaskEmptyState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  List<Task> taskList;
  TaskLoadedState({required this.taskList});
}

class TaskErrorState extends TaskState {}
