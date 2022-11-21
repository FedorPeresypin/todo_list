import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/storage/storage_service_impl.dart';
import '../../entity/group.dart';

part 'group_edit_event.dart';
part 'group_edit_state.dart';

class GroupEditBloc extends Bloc<GroupEditEvent, GroupEditState> {
  final _groupDataProvider = StorageServiceImpl();
  late int index;
  late Group group;
  GroupEditBloc() : super(GroupInitialState()) {
    on<GroupShowEditorEvent>((event, emit) async {
      group = await _groupDataProvider.getGroup(event.indexGroup);
      index = event.indexGroup;
      emit(GroupEditorState(group: group));
    });
    on<GroupChangeEvent>((event, emit) async {
      _groupDataProvider.editGroup(group: Group(name: event.name, tasks: group.tasks), indexGroup: index);
    });
  }
}
