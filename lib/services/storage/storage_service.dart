import 'package:todo_list/business_logic/entity/group.dart';

abstract class StorageService {
  Future<List<Group>> getGroups();
  Future<void> saveGroup(Group group);
  Future<void> deleteGroup(int groupIndex);
}
