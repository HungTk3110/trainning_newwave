import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:training_newwave/model/note_entity.dart';

class NoteDatabaseHelper {
  static const _databaseName = "hungtk.db";
  static const _databaseVersion = 1;

  static const table = 'note';

  static const columnId = '_id';
  static const columnTitle = 'title';
  static const columnDescribe = 'describe';
  static const columnColor = 'color';

  NoteDatabaseHelper._privateConstructor();

  static final NoteDatabaseHelper instance = NoteDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database?> get database1 async {
    _database ??= await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnTitle TEXT NOT NULL,
            $columnDescribe TEXT NOT NULL,
            $columnColor INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insertNote(Map<String, dynamic> note) async {
    Database? db = await instance.database;
    return await db.insert(table, note);
  }

  Future<List<NoteEntity>> queryAllNotes() async {
    List<NoteEntity> listNote = [];
    try {
      Database db = await instance.database;

      var data = await db.query(table);

      for (int i = 0; i < data.length; i++) {
        final note = NoteEntity.fromDbMap(data[i]);
        listNote.add(note);
      }
      // for (var item in data) {
      //   listNote.add(NoteEntity.fromDbMap(item));
      // }

      print("do dai: ${listNote.length}");
      return listNote;

    } catch (e) {
      return [];
    }
  }

  // Future<NoteEntity> queryNote(int id) async {
  //   Database db = await instance.database;
  //   var query = Sqflite.firstIntValue(
  //       await db.rawQuery('SELECT COUNT(*) FROM $table')) ;
  // }

  Future<int> queryNoteCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table')) ?? 0;
  }

  Future<int> updateNote(Map<String, dynamic> note) async {
    Database db = await instance.database;
    int id = note[columnId];
    return await db.update(table, note, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
