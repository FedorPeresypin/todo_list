import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/storage/storage_service_impl.dart';
import '../../entity/group.dart';

part 'group_edit_event.dart';
part 'group_edit_state.dart';

class GroupEditBloc extends Bloc<GroupEditEvent, GroupEditState> {
  final _groupDataProvider = StorageServiceImpl();
  GroupEditBloc() : super(GroupInitialState()) {
    on<GroupShowEditorEvent>((event, emit) async {
      final group = await _groupDataProvider.getGroup(event.indexGroup);
      emit(GroupEditorState(group: group));
    });
  }
}
