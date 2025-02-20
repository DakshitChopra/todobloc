/*
TO DO VIEW: responsible for UI

- using BlocBuilder

*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

import '../domain/models/todo.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //show dialog box for user to type
  void _showAddTodoBox(BuildContext context){
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context)=> AlertDialog(
          content: TextField(controller: textController),
          actions: [
            // cancel button
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
            ),
            //add button
            TextButton(
              onPressed: () {
                todoCubit.addTodo(textController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
    );
  }
  //Building UI
  @override
  Widget build(BuildContext context) {

    //to-do CUBIT
    final todoCubit = context.read<TodoCubit>();

    //SCAFFOLD
    return Scaffold(
      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:() => _showAddTodoBox(context),
      ),
      //Bloc Builder
      body: BlocBuilder<TodoCubit,List<Todo>>(
        builder: (context, todos) {
          //List view
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual to-do from todos list
              final todo = todos[index];

              //List Tile UI
              return ListTile(
                // text
                title:Text(todo.text),
                // checkbox
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),
                //delete button
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () => todoCubit.deleteTodo(todo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
