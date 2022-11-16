part of 'group_edit_bloc.dart';

abstract class GroupEditState {}

class GroupInitialState extends GroupEditState {}

class GroupEditorState extends GroupEditState {
  Group group;
  GroupEditorState({required this.group});
}
