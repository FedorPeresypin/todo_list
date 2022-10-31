import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task extends HiveObject {
  @HiveField(0)
  String name;
  Task({required this.name});

  @override
  String toString() => name;
}
