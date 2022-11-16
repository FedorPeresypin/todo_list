import 'package:hive_flutter/hive_flutter.dart';
import '../../business_logic/entity/group.dart';
import 'storage_service.dart';

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

  @override
  Future<void> deleteGroup(int groupIndex) async {
    final box = await Hive.openBox<Group>('group_box');
    await box.deleteAt(groupIndex);
  }

  @override
  Future<void> updateGroupList({required List<Group> groupList}) async {
    final box = await Hive.openBox<Group>('group_box');
    await box.clear();
    for (var element in groupList) {
      await box.add(Group(name: element.name));
    }
  }

  @override
  Future<void> editGroup({required Group group, required int indexGroup}) async {
    final box = await Hive.openBox<Group>('group_box');
    await box.putAt(indexGroup, group);
  }
}
