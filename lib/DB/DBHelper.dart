import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get database async {
    _db = await initdb();
    return _db;
  }

  Future<Database> initdb() async {
    Directory doc = await getApplicationDocumentsDirectory();
    String path = join(doc.path, 'App.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shops (
      id INTEGER PRIMARY KEY,
      com TEXT)
    ''');
  }
}