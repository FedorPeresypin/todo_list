import '../entity/group.dart';

abstract class GroupState {}

class GroupLoadingState extends GroupState {}

class GroupEmptyState extends GroupState {}

class GroupLoadedState extends GroupState {
  List<Group> groups;
  GroupLoadedState({required this.groups});
}

class GroupErrorState extends GroupState {}
