import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/group/groups_add_screen.dart';
import '../views/group/groups_screen.dart';
import '../views/group/group_edit_screen.dart';
import '../views/task/task_add_screen.dart';
import '../views/task/tasks_screen.dart';
import '../../business_logic/bloc/group_bloc/group_bloc.dart';
import '../../business_logic/bloc/group_edit_bloc/group_edit_bloc.dart';
import '../../business_logic/bloc/task_bloc/task_bloc.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupBloc>(
          create: (BuildContext context) => GroupBloc()..add(GroupInitialiseEvent()),
        ),
        BlocProvider<GroupEditBloc>(
          create: (BuildContext context) => GroupEditBloc(),
        ),
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(),
        )
      ],
      child: MaterialApp(
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/groups',
        routes: {
          '/groups': (context) => const GroupScreen(),
          '/groups/form': (context) => GroupsAddScreen(),
          '/groups/edit': (context) => GroupEditScreen(),
          '/groups/tasks': (context) => const TasksScreen(),
          '/groups/tasks/form': (context) => TaskAddScreen()
        },
      ),
    );
  }
}
