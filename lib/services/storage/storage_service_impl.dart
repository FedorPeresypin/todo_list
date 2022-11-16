import 'dart:developer';

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

  @override
  Future<void> deleteGroup(int groupIndex) async {
    final box = await Hive.openBox<Group>('group_box');
    await box.deleteAt(groupIndex);
  }

  Future<List<Group>> reorderGrops({required int oldIndex, required int newIndex}) async {
    final box = await Hive.openBox<Group>('group_box');
    final groupList = box.values.toList();
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = groupList.removeAt(oldIndex);
    groupList.insert(newIndex, item);

    await box.clear();
    for (var element in groupList) {
      await box.add(Group(name: element.name));
    }
    return groupList;
  }
}
