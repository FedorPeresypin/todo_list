part of 'group_edit_bloc.dart';

abstract class GroupEditEvent {}

class GroupEditInitialiseEvent extends GroupEditEvent {}

class GroupShowEditorEvent extends GroupEditEvent {
  int indexGroup;
  GroupShowEditorEvent({required this.indexGroup});
}

class GroupChangeEvent extends GroupEditEvent {
  String name;
  GroupChangeEvent({required this.name});
}
