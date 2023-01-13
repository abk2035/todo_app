import 'package:flutter/material.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text("${index.toString()}done");
      },
      itemCount: 20,
      shrinkWrap: true,
    );
  }
}
