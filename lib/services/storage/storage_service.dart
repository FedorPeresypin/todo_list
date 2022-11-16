import '../../business_logic/entity/group.dart';

abstract class StorageService {
  Future<List<Group>> getGroups();
  Future<void> saveGroup(Group group);
  Future<void> deleteGroup(int groupIndex);
  Future<void> updateGroupList({required List<Group> groupList});
  Future<void> editGroup({required Group group, required int indexGroup});
}
