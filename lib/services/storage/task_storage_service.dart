import '../../business_logic/entity/task.dart';

abstract class TaskStorageService {
  Future<void> addTask({required Task task, required int groupId});
  Future<List<Task>> getTaskList({required int groupId});
}
