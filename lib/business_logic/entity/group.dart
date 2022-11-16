import 'package:hive/hive.dart';
import 'package:todo_list/business_logic/entity/task.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
class Group extends HiveObject {
  @HiveField(0)
  String name;

  // @HiveField(1)
  // int indexGroup;

  @HiveField(2)
  HiveList<Task>? tasks;

  Group({required this.name, this.tasks});

  @override
  String toString() {
    return 'name: $name, tasks: $tasks';
  }
}
