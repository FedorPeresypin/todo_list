import 'package:flutter/material.dart';
import 'package:todo_list/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  GroupFormWidgetState createState() => GroupFormWidgetState();
}

class GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
      model: _model,
      child: const GroupFormWidgetBody(),
    );
  }
}

class GroupFormWidgetBody extends StatelessWidget {
  const GroupFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New group'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: GroupTextWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.done),
        onPressed: () => GroupFormWidgetModelProvider.of(context)?.model.saveGroup(context),
      ),
    );
  }
}

class GroupTextWidget extends StatelessWidget {
  const GroupTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.of(context)?.model;
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Name group',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () => model?.saveGroup(context),
    );
  }
}
