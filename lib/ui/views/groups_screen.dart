import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/viewmodels/groups_viewmodel.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups todolists'),
        centerTitle: true,
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/groups/form'),
      ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget();

  @override
  Widget build(BuildContext context) {
    final groupsCount = context.watch<GroupsViewModel>().groups.length;
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        itemBuilder: (context, index) => _GroupListRowWidget(key: Key('$index'), indexInList: index),
        itemCount: groupsCount,
        onReorder: (oldIndex, newIndex) => context.read<GroupsViewModel>().reorderGroup(oldIndex, newIndex),
      ),
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = context.watch<GroupsViewModel>().groups[indexInList];
    return Dismissible(
      key: Key('$indexInList'),
      secondaryBackground: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          color: const Color.fromARGB(69, 244, 67, 54),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
      background: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          color: const Color.fromARGB(69, 64, 195, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.settings,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
        ),
      ),
      child: Card(
        child: ListTile(
          title: Text(group.name),
          subtitle: Text(group.indexGroup.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => context.read<GroupsViewModel>().deleteGroup(indexInList),
          ),
        ),
      ),
    );
  }
}
