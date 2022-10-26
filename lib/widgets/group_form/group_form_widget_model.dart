import 'dart:developer';

import 'package:flutter/material.dart';

class GroupFormWidgetModel {
  String groupName = '';
  void saveGroup(BuildContext context) {
    log(groupName);
    Navigator.of(context).pop();
  }
}

class GroupFormWidgetModelProvider extends InheritedWidget {
  const GroupFormWidgetModelProvider({super.key, required this.model, required Widget child}) : super(child: child);

  final GroupFormWidgetModel model;

  static GroupFormWidgetModelProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupFormWidgetModelProvider>();
  }

  @override
  bool updateShouldNotify(GroupFormWidgetModelProvider oldWidget) {
    return true;
  }
}
