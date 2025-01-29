/*
TO DO CUBIT - simple state management in bloc

Each cubit is a list of todos.
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import '../domain/models/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  //Reference to-do repo
  final TodoRepo todoRepo;

  //Constructor initializes the cubit with an empty list
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //LOAD
  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();

    //emit the fetched list as the new state
    emit(todoList);
  }
  //ADD
  Future<void> addTodo(String text) async{
  //create a new to-do with unique Id
  final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text:text,
  );
  //save the new to-do to repo
  await todoRepo.addTodo(newTodo);
  //re-load
    loadTodos();
  }
  //DELETE
  Future<void> deleteTodo(Todo todo) async{
    //delete the provided todo from repo
    await todoRepo.deleteTodo(todo);
    //re-load
    loadTodos();
  }
  //TOGGLE
  Future<void> toggleCompletion(Todo todo) async{
    //toggle the completion status of provided todo
    final updatedTodo = todo.toggleCompletion();

    //update the to-do in repo  with new completion status
    await todoRepo.updateTodo(updatedTodo);

    //re-load
    loadTodos();
  }
}