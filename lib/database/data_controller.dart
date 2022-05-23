import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/todo_model.dart';

class DatabaseController {
  DatabaseController._dataController();

  static final DatabaseController databaseController =
      DatabaseController._dataController();
  static Database? _database;
  static const _databaseName = 'todo.db';
  static const _tableName = 'todoTable';
  static const int _version = 1;

  Future<Database?> get myDatabase async {
    if (_database != null) return _database;
    return _database = await _initializingDatabase();
  }

  _initializingDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  _onCreate(Database? database, int version) async {
    await database!.execute('''
    CREATE TABLE $_tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    time TEXT
    )
    ''');
  }

  Future<TodoModel> insertTodo(TodoModel todoModel) async {
    print('${todoModel.toTodoMap()} INSERTED Successfully');
    Database? db = await myDatabase;
    await db!.insert(_tableName, todoModel.toTodoMap());
    return todoModel;
  }

  Future<List<TodoModel>> getAllTodo() async {
    Database? db = await myDatabase;
    List<Map<String, dynamic>> result = await db!.query(_tableName);
    return result.map((todo) => TodoModel.fromTodo(todo)).toList();
  }

  Future<int> deleteTodo(int id) async {
    Database? db = await myDatabase;
    return await db!.delete(_tableName, where: 'id ==?', whereArgs: [id]);
  }

  updateTodo(TodoModel todoModel) async {
    Database? db = await myDatabase;
    return db!.update(_tableName, todoModel.toTodoMap(),
        where: 'id == ?', whereArgs: [todoModel.id]);
  }
}
