import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/entity/task.dart';

import '../../../services/storage/task_storage_service_impl.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _groupDataProvider = TaskStorageServiceImplement();
  late List<Task> taskList;
  TaskBloc() : super(TaskInitializeState()) {
    on<TaskInitialiseEven>(
      (event, emit) async {
        emit(TaskLoadingState());
        try {
          taskList = await _groupDataProvider.getTaskList(groupId: event.indexGroup);
          taskList.isEmpty ? emit(TaskEmptyState()) : emit(TaskLoadedState(taskList: taskList));
        } catch (e) {
          emit(TaskErrorState());
        }
      },
    );
  }
}
