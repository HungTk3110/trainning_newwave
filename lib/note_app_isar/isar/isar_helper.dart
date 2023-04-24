import 'package:isar/isar.dart';
import 'package:training_newwave/model/note_isar_entity.dart';

class FireBaseHelper {
  static final FireBaseHelper _instance = FireBaseHelper._internal();

  factory FireBaseHelper() => _instance;

  FireBaseHelper._internal();

  late Isar isar;

  Future<Isar> init() async {

    isar = await Isar.open(
      [NoteIsarEntitySChema],
      inspector: true,
      directory: '',
    );

    return isar;
  }
}
