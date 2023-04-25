import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:training_newwave/model/note_isar_entity.dart';

class IsarHelper {
  IsarHelper._privateConstructor();

  static final IsarHelper instance = IsarHelper._privateConstructor();
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteIsarEntitySchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Future<List<NoteIsarEntity>> getAllNote() async {
    final allNote = await isar.noteIsarEntitys.where().findAll();
    return allNote;
  }

  Future<NoteIsarEntity?> getNoteById(Id id) async {
    final note = isar.noteIsarEntitys.getSync(id);
    return note;
  }

  Future<void> insertNote({
    required String title,
    required String describe,
    required int color,
  }) async {
    final note = NoteIsarEntity(
      title: title,
      describe: describe,
      color: color,
    );

    await isar.writeTxn(() async {
      isar.noteIsarEntitys.put(note);
    });
  }

  Future<void> deleteNoteById(Id id) async {
    await isar.writeTxn(() async {
      isar.noteIsarEntitys.delete(id);
    });
  }

  Future<void> updateNote({
    required NoteIsarEntity note,
    required String title,
    required String describe,
    required int color,
  }) async {
    await isar.writeTxn(() async {
      note
        ..title = title
        ..describe = describe
        ..color = color;

      await isar.noteIsarEntitys.put(note);
    });
  }

  Future<List<NoteIsarEntity>> searchNotesByTitle(String title) async {
    final searchResult = await isar.noteIsarEntitys.filter().titleStartsWith(title).findAll();
    return searchResult;
  }
}

/*
1. Tạo thói quen format code, thêm dấu , vào cuối câu
2. Tối ưu lại các Widget sau khi đã làm xong màn hình, nghĩ xem có cách nào khác hay hơn không
3. Cải thiện để không bị lặp code khi dùng chung các chức năng trong màn hình
*/
