import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/bloc/group_bloc/group_bloc.dart';
import '../../../business_logic/bloc/group_edit_bloc/group_edit_bloc.dart';

class GroupEditScreen extends StatelessWidget {
  GroupEditScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEditBloc, GroupEditState>(
      builder: (context, state) {
        if (state is GroupEditorState) {
          controller.text = state.group.name.toString();
          return Scaffold(
            appBar: AppBar(
              title: Text(state.group.name.toString()),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Name group',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.done),
              onPressed: () {
                context.read<GroupEditBloc>().add(GroupChangeEvent(name: controller.text));
                Navigator.of(context).pop();
                context.read<GroupBloc>().add(GroupInitialiseEvent());
              },
            ),
          );
        }
        if (state is GroupErrorState) {
          return const Center(
            child: Text('Error'),
          );
        }
        throw Exception('Что-то пошло не так...');
      },
    );
  }
}
