import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/business_logic/entity/task.dart';

class TaskViewModel extends ChangeNotifier {
  late final Box<Group> box;
  late final Box<Task> boxTask;
  late Group group;
  TaskViewModel() {
    hiveSetup();
  }
  void showTasks(BuildContext context, {required Group group}) {
    this.group = group;
    Navigator.of(context).pushNamed('/groups/tasks');
  }

  void hiveSetup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    box = await Hive.openBox<Group>('group_box');
    boxTask = await Hive.openBox<Task>('task_box');
  }

  void addTask(Task task) async {
    group.tasks ??= HiveList(boxTask);
    await boxTask.add(task);
    group.tasks!.add(task);
    group.save();
    notifyListeners();
  }

  void deleteTask(Task task) async {}
}
