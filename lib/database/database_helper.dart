import 'package:login_anja_mona/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String userTable = 'userTable';
  String colId = 'id';
  String colName = 'name';
  String colPassword = 'password';
  String colCounter = 'counter';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'quiz.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(
        path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE $userTable(
        $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $colName TEXT NOT NULL,
        $colPassword TEXT NOT NULL, 
        $colCounter INTEGER)
        ''');
  }

  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $userTable');
    // var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertUser(String name, String pw) async {
    var db = await this.database;
    // var result = await db.update(userTable, user.toMap(), where: '$colId = ?', whereArgs: [user.id]);
    var result = await db.rawInsert('''
      INSERT INTO $userTable (
      $colName, $colPassword
      ) VALUES (?,?)
    ''', [name, pw]);
    print('insert: $result');
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'User List' [ List<Note> ]
  Future<List<User>> getUserList() async {
    var userMapList = await getUserMapList(); // Get 'Map List' from database
    int count = userMapList.length; // Count the number of map entries in db table

    List<User> userList = List<User>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  Future<User> getCurrentUser(int id) async {
    final db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $userTable WHERE id = $id');
    print("user with no $id");
    return result.isNotEmpty ? User.fromMapObject(result.first) : Null;
  }

/*
  Future<User> getCurrentUser(int id) async {
    final db = await this.database;
    var result = await db.query("user", where: "id = ", whereArgs: [id]);
    print("user with no $id");
    return result.isNotEmpty ? User.fromMapObject(result.first) : Null;
  }

 */

}







