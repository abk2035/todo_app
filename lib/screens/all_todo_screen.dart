import 'package:flutter/material.dart';

class AllTodoScreen extends StatelessWidget {
  const AllTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text("${index.toString()} all to do");
      },
      itemCount: 20,
      shrinkWrap: true,
    );
  }
}
