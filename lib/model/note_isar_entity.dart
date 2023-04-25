import 'package:isar/isar.dart';
part 'note_isar_entity.g.dart';

@collection
class NoteIsarEntity {

  Id id = Isar.autoIncrement;
  String? title;
  String? describe;
  int? color;

  NoteIsarEntity({
    this.title,
    this.color,
    this.describe,
  });

  NoteIsarEntity.fromDbMap(dynamic obj) {
    id = obj['_id'];
    title = obj['title'];
    describe = obj['describe'];
    color = obj['color'];
  }

  Map<String, dynamic> toDbMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'describe': describe,
      'color': color,
    };
  }
}
