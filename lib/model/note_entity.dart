class NoteEntity {
  dynamic id;
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

  Map<String, dynamic> toDbMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'describe': describe,
      'color': color,
    };
  }
}
