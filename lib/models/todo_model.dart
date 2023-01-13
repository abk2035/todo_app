import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String title;
   @HiveField(1)
  final String description;
   @HiveField(3)
  final DateTime date;
   @HiveField(4)
  final bool isDone;
   @HiveField(5)
  final bool isArchived;

  TodoModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.isArchived,
      required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'isDone': isDone,
      'isArchived': isArchived,
    };
  }
}
