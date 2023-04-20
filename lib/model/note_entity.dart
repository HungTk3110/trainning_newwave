class NoteEntity {
  int? id;
  String? title;
  String? describe;
  int? color;

  NoteEntity({
    this.id,
    this.title,
    this.color,
    this.describe,
  });

  NoteEntity.fromDbMap(dynamic obj) {
    id = obj['_id'];
    title = obj['title'];
    describe = obj['describe'];
    color = obj['color'];
  }

  Map<String, dynamic> toDbMap(dynamic obj) {
    var map = <String, dynamic>{};
    map['_id'] = obj.id;
    map['title'] = obj.title;
    map['describe'] = obj.describe;
    map['color'] = obj.color;
    return map;
  }
}
