/*
DATABASE REPO

This implements the to-do repo and handles storing, retrieving, updating, deleting in the isar database

*/

import 'package:isar/isar.dart';
import 'package:todo_bloc/data/models/isar_todo.dart';
import '../../domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';


class IsarTodoRepo implements TodoRepo{
  //database
  final Isar db;

  IsarTodoRepo(this.db);

  //get todos
  @override
  Future<List<Todo>> getTodos() async {
    //fetch from db
    final todos = await db.todoIsars.where().findAll();
    // return as a list of todos and give to domain layer
    return todos.map((todoIsar)=> todoIsar.toDomain()).toList();
  }
  // add to-do
  @override
  Future<void> addTodo(Todo newTodo) async {
    //convert to-do into isar to-do
    final todoIsar = TodoIsar.fromDomain(newTodo);
    // so that we can store it in our isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
  // update to-do
  @override
  Future<void> updateTodo(Todo todo) {
    //convert to-do into isar to-do
    final todoIsar = TodoIsar.fromDomain(todo);
    // so that we can store it in our isar db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }
  // delete to-do
  @override
  Future<void> deleteTodo(Todo todo) async{

    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}