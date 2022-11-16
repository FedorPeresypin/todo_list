import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/group_event.dart';
import 'package:todo_list/business_logic/bloc/group_state.dart';
import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/services/storage/storage_service_impl.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final _groupDataProvider = StorageServiceImpl();
  late List<Group> groupList;
  GroupBloc() : super(GroupEmptyState()) {
    on<GroupInitialiseEvent>((event, emit) async {
      groupList = await _groupDataProvider.getGroups();
      emit(GroupLoadingState());
      try {
        List<Group> groups = await _groupDataProvider.getGroups();
        if (groups.isEmpty) emit(GroupEmptyState());
        emit(GroupLoadedState(groups: groups));
      } catch (e) {
        emit(GroupErrorState());
      }
    });

    on<GroupDeleteEvent>(
      (event, emit) async {
        await _groupDataProvider.deleteGroup(event.indexGroup);
        groupList = await _groupDataProvider.getGroups();
        if (groupList.isEmpty) emit(GroupEmptyState());
        emit(GroupLoadedState(groups: groupList));
      },
    );

    on<GroupAddEvent>(
      (event, emit) async {
        if (event.name.isEmpty) return;
        final group = Group(name: event.name);
        await _groupDataProvider.saveGroup(group);
        groupList = await _groupDataProvider.getGroups();
        emit(GroupLoadedState(groups: groupList));
      },
    );

    on<GroupReorderEvent>(
      (event, emit) async {
        var newIndex = event.newIndex;
        var oldIndex = event.oldIndex;
        if (newIndex > oldIndex) newIndex--;
        final reorderGroup = groupList.removeAt(oldIndex);
        groupList.insert(newIndex, reorderGroup);
        emit(GroupLoadedState(groups: groupList));
        _groupDataProvider.updateGroupList(groupList: groupList);
      },
    );
  }
}
