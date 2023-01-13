import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_states.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialAppState());
  int currentIndex = 0;

    // controllers
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  static TodoCubit get(context) => BlocProvider.of(context);

  setBottomIndex(int index) {
    currentIndex = index;
    emit(SetCurrentIndexAppState());
  }

  getBox() {}

  clearController() {
    descriptionController.clear();
    titleController.clear();
  }
}
