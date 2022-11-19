import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/business_logic/entity/task.dart';

import '../../business_logic/entity/group.dart';
import 'task_storage_service.dart';

class TaskStorageServiceImplement implements TaskStorageService {
  @override
  Future<void> addTask({required Task task, required int groupId}) async {
    final box = await Hive.openBox<Group>('group_box');
    final boxTask = await Hive.openBox<Task>('task_box');
    final group = box.getAt(groupId);
    if (group != null) {
      await boxTask.add(task);
      group.tasks ??= HiveList(boxTask);
      group.tasks!.add(task);
      group.save();
    }
  }

  @override
  Future<List<Task>> getTaskList({required int groupId}) async {
    final box = await Hive.openBox<Group>('group_box');
    final boxTask = await Hive.openBox<Task>('task_box');
    final group = box.getAt(groupId);
    if (group != null) {
      group.tasks ??= HiveList(boxTask);
      return group.tasks!;
    }
    return throw UnimplementedError();
  }
}
