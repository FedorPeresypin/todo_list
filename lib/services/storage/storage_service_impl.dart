import 'package:todo_list/business_logic/entity/group.dart';
import 'package:todo_list/services/storage/storage_service.dart';

class StorageServiceImpl implements StorageService {
  @override
  Future<List<Group>> getGroups() async {
    return [Group(name: 'name', indexGroup: 0), Group(name: 'name', indexGroup: 1)];
  }

  @override
  Future<void> saveGroup(Group group) {
    // TODO: implement saveGroup
    throw UnimplementedError();
  }
}
