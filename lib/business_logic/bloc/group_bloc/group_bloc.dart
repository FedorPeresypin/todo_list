import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/storage/storage_service_impl.dart';
import '../../entity/group.dart';

part 'group_event.dart';
part 'group_state.dart';

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
        await _groupDataProvider.updateGroupList(groupList: groupList);
        groupList = await _groupDataProvider.getGroups();
        emit(GroupLoadedState(groups: groupList));
      },
    );
  }
}
