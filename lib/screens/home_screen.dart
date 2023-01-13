import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_states.dart';
import 'package:todo_app/screens/all_todo_screen.dart';
import 'package:todo_app/screens/archives_screen.dart';
import 'package:todo_app/screens/done_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> list = [
    const AllTodoScreen(),
    const DoneScreen(),
    const ArchivesScreen(),
  ];

  final List<String> title = [
    "All Tasks",
    "Done",
    "Archives",
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cubit = TodoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(title[cubit.currentIndex]),
            ),
            body: list[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.setBottomIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Archived',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Todo Details"),
                  content: BlocBuilder<TodoCubit, TodoStates>(
                      builder: (context, state) {
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: cubit.titleController,
                            decoration: const InputDecoration(
                              border:
                                  OutlineInputBorder(borderSide: BorderSide()),
                              labelText: 'Title',
                              hintText: 'Enter Title',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'hey  dont leave it empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            controller: cubit.descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Discription',
                              hintText: 'Enter Discription',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'hey dont leave it empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    );
                  }),
                  actions: [
                           TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cubit.clearController();
                          },
                          child: const Text('Cancle')),
                      const SizedBox(
                        height: 20,
                      ),
                  ],
                ),
              ),
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
