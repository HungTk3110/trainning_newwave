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
    id = obj['id'];
    title = obj['title'];
    describe = obj['describe'];
    color = obj['color'];
  }

  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['describe'] = describe;
    map['color'] = color;
    return map;
  }
}
