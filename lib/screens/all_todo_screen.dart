import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_states.dart';
import 'package:todo_app/models/todo_model.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoStates>(builder: (context, state) {
      var cubit = TodoCubit.get(context);
      List<TodoModel>? todosList = [];
      for (var item in cubit.todosList!) {
        if (!item.isArchived && !item.isDone) {
          todosList.add(item);
        }
      }
      return todosList.isEmpty
          ? const Center(
              child: Text('All Todos is empty'),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Text("${index.toString()} all to do");
              },
              itemCount: todosList.length,
              shrinkWrap: true,
            );
    });
  }
}
