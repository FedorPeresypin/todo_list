abstract class GroupEvent {}

class GroupAddEvent extends GroupEvent {}

class GroupDeleteEvent extends GroupEvent {
  final indexGroup;
  GroupDeleteEvent({required this.indexGroup});
}

class GroupReorderEvent extends GroupEvent {}

class GroupEditEvent extends GroupEvent {}

class GroupInitialiseEvent extends GroupEvent {}
