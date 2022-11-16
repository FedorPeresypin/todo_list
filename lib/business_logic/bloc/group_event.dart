abstract class GroupEvent {}

class GroupAddEvent extends GroupEvent {
  final String name;
  GroupAddEvent({required this.name});
}

class GroupDeleteEvent extends GroupEvent {
  final int indexGroup;
  GroupDeleteEvent({required this.indexGroup});
}

class GroupReorderEvent extends GroupEvent {
  int oldIndex;
  int newIndex;
  GroupReorderEvent({required this.newIndex, required this.oldIndex});
}

class GroupEditEvent extends GroupEvent {}

class GroupInitialiseEvent extends GroupEvent {}
