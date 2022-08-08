import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

const todoTABLE = 'Todo';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"DoneDatabase.db is our database instance name
    String path = join(documentsDirectory.path, "DoneDatabase.db");
    return await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute(
      "CREATE TABLE $todoTABLE ("
      "id INTEGER PRIMARY KEY, "
      "description TEXT, "
      "is_done INTEGER "
      "category TEXT" // SQLITE doesn't have boolean type
      ")",
    );
  }
}
