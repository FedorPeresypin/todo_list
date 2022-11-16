import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/services/storage/storage_service.dart';

class StorageServiceImpl implements StorageService {
  @override
  Future<List<Group>> getGroups() async {
    final box = await Hive.openBox<Group>('group_box');
    return box.values.toList();
  }

  @override
  Future<void> saveGroup(Group group) async {
    final box = await Hive.openBox<Group>('group_box');
    await box.add(group);
  }

  Future<void> deleteGroup(int groupIndex) async {
    final box = await Hive.openBox<Group>('group_box');
    await box.deleteAt(groupIndex);
  }
}
