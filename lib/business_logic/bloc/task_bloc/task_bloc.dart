import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/entity/task.dart';

import '../../../services/storage/task_storage_service_impl.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _taskDataProvider = TaskStorageServiceImplement();
  late List<Task> taskList;
  late int groupId;
  TaskBloc() : super(TaskInitializeState()) {
    on<TaskInitialiseEvent>(
      (event, emit) async {
        emit(TaskLoadingState());
        try {
          taskList = await _taskDataProvider.getTaskList(groupId: event.indexGroup);
          groupId = event.indexGroup;
          taskList.isEmpty ? emit(TaskEmptyState()) : emit(TaskLoadedState(taskList: taskList));
        } catch (e) {
          emit(TaskErrorState());
        }
      },
    );
    on<TaskAddEvent>(
      (event, emit) async {
        if (event.name.isEmpty) return;
        await _taskDataProvider.addTask(task: Task(name: event.name), groupId: groupId);
        taskList = await _taskDataProvider.getTaskList(groupId: groupId);
        emit(TaskLoadedState(taskList: taskList));
      },
    );

    on<TaskChangeEvent>(
      (event, emit) async {
        event.task.changetask();
        await event.task.save();
        taskList = await _taskDataProvider.getTaskList(groupId: groupId);
        emit(TaskLoadedState(taskList: taskList));
      },
    );
  }
}
