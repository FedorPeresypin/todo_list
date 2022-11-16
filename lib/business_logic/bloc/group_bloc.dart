import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/business_logic/bloc/group_event.dart';
import 'package:todo_list/business_logic/bloc/group_state.dart';
import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/services/storage/storage_service_impl.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final _groupDataProvider = StorageServiceImpl();
  late List<Group> groups;
  GroupBloc() : super(GroupEmptyState()) {
    on<GroupInitialiseEvent>((event, emit) async {
      groups = await _groupDataProvider.getGroups();
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
        groups = await _groupDataProvider.getGroups();
        if (groups.isEmpty) emit(GroupEmptyState());
        emit(GroupLoadedState(groups: groups));
      },
    );

    on<GroupAddEvent>(
      (event, emit) async {
        if (event.name.isEmpty) return;
        final group = Group(name: event.name);
        await _groupDataProvider.saveGroup(group);
        groups = await _groupDataProvider.getGroups();
        emit(GroupLoadedState(groups: groups));
      },
    );

    on<GroupReorderEvent>(
      (event, emit) async {
        log('event');
        final groups = await _groupDataProvider.reorderGrops(newIndex: event.newIndex, oldIndex: event.oldIndex);
        emit(GroupLoadedState(groups: groups));
      },
    );
  }
}
