import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_states.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    required this.todoModel,
    Key? key,
  }) : super(key: key);

  final TodoModel todoModel;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    return ListTile(
      title: Row(
        children: [
          Text(todoModel.title),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              cubit.deleteTodo(todoModel);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.grey,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Todo Details"),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: cubit.titleController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          labelText: 'Title',
                          hintText: todoModel.title,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "hey  don't leave it empty";
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Description",
                          hintText: todoModel.description,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "hey don't leave it empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              maximumSize: Size.infinite),
                          onPressed: () {
                            cubit.setDate(context);
                          },
                          icon: const Icon(Icons.date_range),
                          label: Text(
                            // Formatted Date
                            DateFormat.yMMMEd()

                                // displaying formatted date
                                .format(cubit.initalDate),
                          )),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        cubit.clearController();
                      },
                      child: const Text('Cancel')),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: const Text('update'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.updateTodo(TodoModel(
                          title: cubit.titleController.text,
                          description: cubit.descriptionController.text,
                          date: cubit.initalDate,
                          isDone: todoModel.isDone,
                          isArchived: todoModel.isArchived,
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('${cubit.titleController.text} modified'),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pop(context);
                        cubit.clearController();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.done),
            color: todoModel.isDone ? Colors.green : Colors.grey,
            onPressed: () {
              cubit.updateTodo(TodoModel(
                title: todoModel.title,
                description: todoModel.description,
                date: todoModel.date,
                isDone: !todoModel.isDone,
                isArchived: false,
              ));
            },
          ),
          IconButton(
              onPressed: () {
                cubit.updateTodo(TodoModel(
                  title: todoModel.title,
                  description: todoModel.description,
                  date: todoModel.date,
                  isDone: false,
                  isArchived: !todoModel.isArchived,
                ));
              },
              icon: Icon(
                Icons.archive,
                color: todoModel.isArchived
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ))
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todoModel.description),
            const SizedBox(
              height: 20,
            ),
            Text(
              // Formatted Date
              DateFormat.yMMMEd().format(todoModel.date),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
