import 'package:flutter/material.dart';

class ArchivesScreen extends StatelessWidget {
  const ArchivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text("${index.toString()}archive");
      },
      itemCount: 20,
      shrinkWrap: true,
    );
  }
}
