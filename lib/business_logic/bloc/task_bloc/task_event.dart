part of 'task_bloc.dart';

abstract class TaskEvent {}

class TaskInitialiseEvent extends TaskEvent {
  int indexGroup;
  TaskInitialiseEvent({required this.indexGroup});
}

class TaskAddEvent extends TaskEvent {
  String name;
  TaskAddEvent({required this.name});
}

class TaskChangeEvent extends TaskEvent {
  Task task;
  TaskChangeEvent({required this.task});
}
