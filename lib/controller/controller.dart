import 'package:flutter/material.dart';
import 'package:todo_app/database/data_controller.dart';
import 'package:todo_app/model/todo_model.dart';

class StateController with ChangeNotifier {
  Future<List<TodoModel>>? _getTodo;
  Future<List<TodoModel>> get getTodo => _getTodo!;
  DatabaseController databaseController = DatabaseController.databaseController;

  Future<List<TodoModel>> getQueryTodoList() async {
    return _getTodo = databaseController.getAllTodo();
  }
}
