part of 'task_bloc.dart';

abstract class TaskEvent {}

class TaskInitialiseEven extends TaskEvent {
  int indexGroup;
  TaskInitialiseEven({required this.indexGroup});
}
