/*
TO DO REPOSITORY

Defining what the app can do

*/

import 'package:todo_bloc/domain/models/todo.dart';

abstract class TodoRepo{
  //get list of todos
  Future<List<Todo>> getTodos();
  //add a new to do
  Future<void> addTodo(Todo newTodo);
  //update an existing to-do
  Future<void> updateTodo(Todo todo);
  //delete a to-do
  Future<void> deleteTodo(Todo todo);
}

/*
Note:
    - the repo in the domain layer outlines what operations the app can do, but
      doesn't worry about the specific implementation details. That's for the data layer.

    - Domain layer should be -> technology agnostic : independent of any technology or framework
*/