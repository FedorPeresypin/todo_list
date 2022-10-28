import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business_logic/viewmodels/groups_viewmodel.dart';
import 'package:todo_list/ui/views/groups_add_screen.dart';
import 'package:todo_list/ui/views/groups_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GroupsViewModel()),
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
        },
      ),
    );
  }
}
