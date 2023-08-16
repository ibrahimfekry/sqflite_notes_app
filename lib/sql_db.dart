import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db;

  Future<Database?> get db async {
    //if database not initalized
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  //initialize Database
  initDb() async {
    //Directory to save data base
    String databasePath = await getDatabasesPath();
    //choose database name and link it with database path
    String path = join(databasePath, 'dbName.db',);
    // create database
    Database myDB = await openDatabase(path
      , onCreate: _onCreateDB, //to create Database
      version: 6, // change version when updating database
      onUpgrade: _onUpgradeDB, // to update database
    );
    return myDB;
  }

//summon only once in the beginning of creating database
  _onCreateDB(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(
        'CREATE TABLE  notes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
            'title TEXT NOT NULL, note TEXT NOT NULL )');
    print('Create Table notes ');
    print('onCreate---------------------------');
    await batch.commit();
  }

// if i want to update in the database , change the version of database before using it
  _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    print('onUpgrade---------------------------');
    await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

// Select data ,get data from database
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

// Insert data
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

//Update database
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

//Delete From database
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  //Delete all of the database
  deleteMyDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'dbName.db',);
    await deleteDatabase(path);
  }


  //Shortcut methods to easily assign sqflite methods

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table,Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table ,values );
    return response;
  }

  update(String table,Map<String, Object?> values,String where) async {
    Database? mydb = await db;
    int response = await mydb!.update(table,values,where: where);
    return response;
  }

  delete(String table,String where) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table,where: where);
    return response;
  }

}