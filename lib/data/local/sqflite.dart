import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqflite {
  static Database? _db;
  Future<Database?> get dB async {
    _db ??= await initialDb();
    return _db;
  }

  initialDb() async {
    //path / news.db
    String databasePath = await getDatabasesPath();
    String databaseName = 'news.db';
    String path = join(databasePath, databaseName);
    Database? myDB = await openDatabase(path, onCreate: _onCreate,version: 1);

    return myDB;
  }

  deleteDb() async {
    //path / news.db
    String databasePath = await getDatabasesPath();
    String databaseName = 'news.db';
    String path = join(databasePath, databaseName);
    return await deleteDatabase(path);

  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "news"(
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "title" TEXT NOT NULL,
        "description" TEXT NOT NULL
      )
  ''');
    print('Create ============');
  }

  //CRUD OPERATIONS

  insertData(String table, Map<String, Object?> values) async {
    Database? myDbd = await dB;
    int response = await myDbd!.insert(table, values);
    return response;
  }

  readData(String table) async {
    Database? myDbd = await dB;
    List<Map> response = await myDbd!.query(table);
    return response;
  }

  updateData(String table, Map<String, Object?> values,String myWhere) async {
    Database? myDbd = await dB;
    int response = await myDbd!.update(table, values,where: myWhere);
    return response;
  }
  deleteData(String table, Map<String, Object?> values,String myWhere) async {
    Database? myDbd = await dB;
    int response = await myDbd!.delete(table,where: myWhere);
    return response;
  }





}
