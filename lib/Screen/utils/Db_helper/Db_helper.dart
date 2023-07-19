
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quotes/Screen/Model/custom_model.dart';
import 'package:quotes/Screen/Model/quotes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper
{
  static final DbHelper helper=DbHelper();

  Database? database;
  final String? dbpath = 'datatable.db';
  final String? db_name = 'quotes';
  final String? db_name1 = 'categoryquotes';

  Future<Database?> checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await initcDb();
    }
  }
  Future<Database> initcDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String? path = join(dir.path, dbpath);

    String? query = "CREATE TABLE $db_name1 (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,img BLOB)";
    String? query1 = "CREATE TABLE $db_name (id INTEGER PRIMARY KEY AUTOINCREMENT ,name TEXT, quote TEXT,category TEXT)";
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
         await db.execute(query);
         await db.execute(query1);
      },
    );
  }


  Future<Future<int>> insertcDb({CategoryModel? model}) async {
    database = await checkDB();
   return database!.insert('$db_name1', {
      'category':model!.cat,
     'img':model.img
    });
  }
  Future<List<Map>> readcData()
  async {
    database = await checkDB();
    String query1 = 'SELECT * FROM $db_name1';
    List<Map> list = await database!.rawQuery(query1);
    print(list);
    return list;
  }

  Future<Future<int>> insertDb(QuotesModel model) async {
    database=await checkDB();

    return database!.insert('$db_name', {
      'name':model.name,
      'quote':model.quotes,
      'category':model.cat,
    });
  }

  Future<List<Map>> readData({required cat})
  async {
    database = await checkDB();
    String query = 'SELECT * FROM $db_name WHERE category = "$cat"';
    List<Map> list = await database!.rawQuery(query);
    print(list);
    return list;
  }

  Future<Future<int>> delete(id)
  async {
    database = await checkDB();
    return database!.delete('$db_name',where:"id=?" ,whereArgs:[id]);
  }

  Future<Future<int>> deletecat(id)
  async {
    database = await checkDB();
    return database!.delete('$db_name1',where:"id=?" ,whereArgs:[id]);
  }

  Future<Future<int>> update({required QuotesModel model,required id})
  async {
    database = await checkDB();
    return database!.update(db_name!, {
      'name':model.name,
      'quote':model.quotes,
      'category':model.cat,
    },where: "id=?",whereArgs: [id]);
  }
 }