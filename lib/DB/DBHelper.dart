import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'ItemList.dart';
import 'ShopList.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get database async {
    _db = await initdb();
    return _db;
  }

  Future<Database> initdb() async {
    Directory doc = await getApplicationDocumentsDirectory();
    String path = join(doc.path, 'shop.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shops (
      id INTEGER PRIMARY KEY,
      count INTEGER,
      item TEXT,
      price INTEGER)
    ''');

    await db.execute('''
      CREATE TABLE items (
      id INTEGER PRIMARY KEY,
      item TEXT)
    ''');
  }

  Future<void> Insert(int count, int price, String item) async {
     try {
        var dbClient = await database;
        await dbClient?.transaction((txn) async {
          await txn.rawInsert('''
            INSERT INTO shops(count, item, price) VALUES('$count', '$item', '$price')
          ''');
        });
     } catch (e) {
       print('Error insert: $e');
     }
  }

  Future<void> InsertItem(String item) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
            INSERT INTO items(item) VALUES('$item')
          ''');
      });
    } catch (e) {
      print('Error insert: $e');
    }
  }

  Future<void> deleteAll() async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('DELETE FROM shops');
        await txn.rawInsert('DELETE FROM items');
      });
      print('All data clear successfully.');
    } catch (e) {
      print('Error clear: $e');
    }
  }

  Future<List<ShopList>> getAll() async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('shops'))?.cast<Map>();
      List<ShopList> shops = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          shops.add(ShopList.fromMap(maps[i]));
        }
      }
      return shops;
    } catch (e) {
      print('Error getting shops: $e');
      return [];
    }
  }

  Future<List<ItemList>> getAllItem() async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('items'))?.cast<Map>();
      List<ItemList> shops = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          shops.add(ItemList.fromMap(maps[i]));
        }
      }
      return shops;
    } catch (e) {
      print('Error getting shops: $e');
      return [];
    }
  }

  Future<List<ShopList>> getItem(String search) async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('shops'))?.cast<Map>();
      List<ShopList> users = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          if(maps[i]['item'] == search) {
            users.add(ShopList.fromMap(maps[i]));
          }
        }
      }
      return users;
    } catch (e) {
      print('Error getting Item: $e');
      return [];
    }
  }

  Future<List<ItemList>> getItem2(String search) async {
    try {
      var dbClient = await database;
      List<Map>? maps = (await dbClient?.query('items'))?.cast<Map>();
      List<ItemList> users = [];
      if (maps!.isNotEmpty) {
        for (int i = 0; i < maps.length; i++) {
          if(maps[i]['item'] == search) {
            users.add(ItemList.fromMap(maps[i]));
          }
        }
      }
      return users;
    } catch (e) {
      print('Error getting Item: $e');
      return [];
    }
  }

  Future<void> update(ShopList shopList) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawUpdate('''
          UPDATE shops
          SET count = ?, item = ?, price = ?
          WHERE id = ?;
        ''', [shopList.count, shopList.item, shopList.price, shopList.id]);
      });
    } catch (e) {
      print('Error update item: $e');
    }
  }

  Future<void> delete(int id) async {
    try {
      var dbClient = await database;
      await dbClient?.transaction((txn) async {
        await txn.rawInsert('''
          DELETE FROM shops WHERE id = $id
        ''');
      });
    } catch (e) {
      print('Error delete item: $e');
    }
  }
}