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
      return listNote;
    } catch (e) {
      return [];
    }
  }

  Future<int> queryNoteCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table')) ?? 0;
  }

  Future<void> updateNote(Map<String, dynamic> note) async {
    Database db = await instance.database;
    int id = note[columnId];
    await db.update(table, note, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteNote(int id) async {
    Database db = await instance.database;
    await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<NoteEntity> getNote(int id) async {
    try {
      Database db = await instance.database;
      var data = await db.query(table, where: '$columnId = ?', whereArgs: [id], limit: 1);
      final result = NoteEntity.fromDbMap(data[0]);
      return result;
    } catch (e) {
      return NoteEntity();
    }
  }

  Future<List<NoteEntity>> searchNote(String str) async {
    List<NoteEntity> listNote = [];
    try {
      Database db = await instance.database;
      var data = await db.query(table, where: '$columnTitle = ?', whereArgs: [str]);
      for (int i = 0; i < data.length; i++) {
        final note = NoteEntity.fromDbMap(data[i]);
        listNote.add(note);
      }
      return listNote;
    } catch (e) {
      return [];
    }
  }
}
