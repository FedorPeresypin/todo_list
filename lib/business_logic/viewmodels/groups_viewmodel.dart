import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/business_logic/entity/group.dart';

class GroupsViewModel with ChangeNotifier {
  List<Group> _groups = [];
  List<Group> get groups => _groups.toList();
  late final Box<Group> box;

  GroupsViewModel() {
    _hiveSetup();
  }
  void _hiveSetup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    box = await Hive.openBox<Group>('group_box');
    box.clear();
    showGroups();
  }

  void showGroups() {
    _groups = box.values.toList();
    notifyListeners();
    box.listenable().addListener(() {
      _groups = box.values.toList();
      notifyListeners();
    });
  }

  void deleteGroup(int groupIndex) async {
    await box.deleteAt(groupIndex);
    await updateGroup();
    notifyListeners();
  }

  void saveGroup(String groupName) async {
    if (groupName.isEmpty) return;
    final group = Group(name: groupName, indexGroup: groups.length);
    await box.add(group);
  }

  Future<void> updateGroup() async {
    int i = 0;
    await box.clear();
    for (var element in groups) {
      await box.add(Group(name: element.name, indexGroup: i));
      i++;
    }
  }
}
