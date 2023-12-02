import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Date.dart';

class SQLiteDbProvider {
  var foodMap = {
    'Apple': 59, 
    'Banana': 151, 
    'Grapes': 100,
    'Orange': 53,
    'Asparagus': 27,
    'Broccoli': 45,
    'Carrots':50,
    'Cucumber':17,
    'Beef':142,
    'Chicken':136,
    'Tofu':86,
    'Egg':78,
    'Bread':75,
    'Butter':102,
    'Caesar salad':481,
    'Cheeseburger':285,
    'Beer':154,
    'Coca-cola':150,
    'Orange Juice':111,
    'Apple Cider':117,
  };

  int id = 1;
  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();

  static late Database _database;

  Future<Database> get database async {
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "DateDB.db");
    return await openDatabase(
      path, 
      version: 1, 
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Date ("
              "id INTEGER PRIMARY KEY,"
              "date TEXT,"
              "calories INTEGER"
        ")");
      }
    );
  }


   insert(Date date) async { 
      final db = await database; 
      var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Date"); 
      var id = maxIdResult.first["last_inserted_id"]; 
      var result = await db.rawInsert(
         "INSERT Into Date (id, date, calories)" 
         " VALUES (?, ?, ?)", 
         [id, date.date, date.calories] 
      ); 
      return result; 
   } 
}