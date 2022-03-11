import 'dart:async';
import 'package:my_todo_app/model/todo_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class Note {
  static Database? _db;
// باكد هل فيه data base ولا لا
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }
// نشاء ال data base
  initialDB() async {
    // المسار الخاص للبرنامج
    io.Directory directory = await getApplicationDocumentsDirectory();
    //اسم ال data base
    String path = join(directory.path, "tododb.db");
    // في كل برنامج جديد لازم اغير رقم ال version
    var mydb = await openDatabase(path, version: 8, onCreate: _onCreate);
    return mydb;
  }
// انشاء الجدوال والاعمدة
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE todo1(id	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,description	TEXT NOT NULL,title	TEXT NOT NULL,date TEXT NOT NULL,done TEXT NOT NULL  )');
  }
  // insert in database
  Future<int> insertdb(Map<String, dynamic> data) async {
    Database? db_Clint = await db;
    var result = db_Clint!.insert("todo1", data);
    return result;
  }
  //delete in database
  Future<int> deletedb(int id) async {
    Database? db_Clint = await db;
    var result = db_Clint!.rawUpdate('DELETE FROM todo1 WHERE id="$id"');
    return result;
  }
//Updatedb in database
  Future<int> Updatedb(String description, int id) async {
    Database? db_Clint = await db;
    var result = db_Clint!.rawUpdate(
        'UPDATE todo1 SET description="$description" WHERE id="$id"');
    return result;
  }
  //get data base
  Future<List<ToDoModel>> getdb() async {
    List<ToDoModel> list = [];
    Database? db_Clint = await db;
    var result = await db_Clint!.query('todo1');
    for (var i in result) {
      list.add(ToDoModel(
          id: i["id"],
        description: i["description"],
          title: i["title"],
          date: i["date"],
          done: i["done"],));
    }
    return list;
  }
  //get Singelrowdb
  Future<List> getSingelrowdb(int id) async {
    Database? db_Clint = await db;
    var result = await db_Clint!.query('todo1', where: 'id"$id"');
    return result;
  }

}



