import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isDone = false;
  Task({required this.name});
  void changetask() {
    isDone = !isDone;
  }

  @override
  String toString() => name;
}
