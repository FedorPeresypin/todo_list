import 'package:flutter/material.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({super.key});
  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/groups/form');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups todolists'),
        centerTitle: true,
      ),
      body: const GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showForm(context),
      ),
    );
  }
}

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({super.key});

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          child: GroupListRowWidget(indexInList: index),
          onDismissed: (direction) {
            //Тут удаляем элемиент из списка
          }),
      itemCount: 10,
    );
  }
}

class GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const GroupListRowWidget({super.key, required this.indexInList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Group name $indexInList'),
        subtitle: const Text('26.10.2022'),
      ),
    );
  }
}
