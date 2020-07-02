import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:randomiser/Models/List_Of_Items.dart';

class TheDB{
  static final _databaseName = "RandomiserApp.db";
  static final _databaseVersion = 1;
  static final table = "Items";
  static final columnId = "_id";
  static final columnListName = "name";
  static final columnItem = "item";

  TheDB._privateConstructor();
  static final TheDB instance = TheDB._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  } 

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $columnListName TEXT NOT NULL,
            $columnItem TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<List_Of_Items>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    
    return List.generate(maps.length, (index){
      return List_Of_Items(
        id: maps[index]['id'],
        name: maps[index]['name'],
        item: maps[index]['item'],
      );
    });
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> deleteList(String listName) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnListName = ?', whereArgs: [listName]);

  }

  Future<int> deleteItem(String itemName, String listName) async {
    Database db = await instance.database;
    return await db.rawDelete("DELETE FROM $table WHERE $columnListName = ? AND $columnItem = ?", [listName, itemName]);
    //return await db.delete(table, where: '$columnItem = ?, $columnListName = ?', whereArgs: [itemName, listName]);
  }

}
