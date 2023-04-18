class Note {
  int id;
  String title;
  String describe;
  int color;

  Note.fromDbMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        describe = map['describe'],
        color = map['color'];

  Map<String, dynamic> toDbMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['describe'] = describe;
    map['color'] = color;
    return map;
  }
}
