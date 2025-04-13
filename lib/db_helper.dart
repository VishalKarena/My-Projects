import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  // Singleton
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  //Table note
  static final String TABLE_NOTE = "note";
  static final String TABLE_NOTE_SNO = "s_no";
  static final String TABLE_NOTE_TITLE = "title";
  static final String TABLE_NOTE_DESC = "desc";

  //   db open(path -> if exists then open else create db
  Database? mydb; //it can be nullable

  Future<Database> getDB() async {
    mydb ??= await openDB();
    return mydb!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "Hello.db");

    return openDatabase(
      dbPath,
      onCreate: (db, version) async {
        //create all database here
        db.execute(
          "create table $TABLE_NOTE($TABLE_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_NOTE_TITLE text, $TABLE_NOTE_DESC text)",
        );
      },
      version: 1,
    );
  }

  //all queries
  //insertion
  Future<bool> addNote({
    required String mTitle,
    required String mDescription,
  }) async {
    var db = await getDB();
    int rowsAffected = await db.insert(TABLE_NOTE, {
      TABLE_NOTE_TITLE: mTitle,
      TABLE_NOTE_DESC: mDescription,
    });
    return rowsAffected > 0;
  }

  // Reading all data
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    //select * from note
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE);
    return mData;
  }

  //Update data
  Future<bool> updateNote({
    required String mTitle,
    required String mDescription,
    required int sno,
  }) async {
    var db = await getDB();

    int rowsAffected = await db.update(TABLE_NOTE, {
      TABLE_NOTE_TITLE: mTitle,
      TABLE_NOTE_DESC: mDescription,
    }, where: "$TABLE_NOTE_SNO = $sno");

    return rowsAffected > 0;
  }

  //Delete data
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();

    int rowsAffected = await db.delete(
      TABLE_NOTE,
      where: "$TABLE_NOTE_SNO = $sno",
    );

    return rowsAffected > 0;
  }
}
