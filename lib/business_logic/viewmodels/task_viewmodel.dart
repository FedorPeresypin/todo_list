import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/business_logic/entity/task.dart';

class TaskViewModel extends ChangeNotifier {
  late final Box<Group> box;
  List<Task> tasks = [];
  late int indexGroup;
  TaskViewModel() {
    hiveSetup();
  }

  void hiveSetup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    box = await Hive.openBox<Group>('group_box');
  }

  void showTasks(BuildContext context, {required int indexGroup}) {
    log(indexGroup.toString());
    this.indexGroup = indexGroup;
    Navigator.of(context).pushNamed('/groups/tasks');
  }
}
