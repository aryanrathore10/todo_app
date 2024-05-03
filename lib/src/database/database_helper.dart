import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/src/database/models/task.dart';

class DatabaseHelper {
  static const dbName = 'tasks.db';
  static const tableName = 'tasks';

  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const isComplete = 'isComplete';
  static const createdAt = 'createdAt';

  DatabaseHelper._();

  static Future<Database> _getInstance() async {
    final dbPath = join(await getDatabasesPath(), dbName);
    final db = await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      String query = 'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $description TEXT, $isComplete INTEGER, $createdAt TEXT)';
      return db.execute(query);
    });
    return db;
  }

  static Future<int> addTask(Task task) async {
    final db = await _getInstance();
    final id = await db.insert(tableName, task.toMap());
    return id;
  }

  static Future<List<Task>> getAllTasks() async {
    final db = await _getInstance();
    final List<Task> tasks = (await db.query(tableName)).map((e)=>Task.fromMap(e)).toList();
    return tasks;
  }

  static Future<void> deleteTask(Task task) async {
    final db = await _getInstance();
    await db.delete(tableName, where: 'id = ?', whereArgs: [task.id]);
  } 

  static Future<int> editTask(int id, Task task) async {
    final db = await _getInstance();
    final data = task.toMap();
    data.remove('id');
    data.remove('isComplete');
    return await db.update(tableName, data, where: 'id = ?', whereArgs: [id]);
  }
}
