import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/business_logic/entity/task.dart';
import 'package:todo_list/ui/app/todo_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveInitial();
  runApp(const TodoApp());
}

Future<void> hiveInitial() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(GroupAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(TaskAdapter());
  }
  await Hive.openBox<Group>('group_box');
  await Hive.openBox<Task>('task_box');
}
