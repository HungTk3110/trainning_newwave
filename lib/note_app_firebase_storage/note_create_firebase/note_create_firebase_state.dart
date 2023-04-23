part of 'note_create_firebase_cubit.dart';

class NoteCreateFirebaseSate extends Equatable {
  final LoadingStatus statusAdd;
  final LoadingStatus statusGet;
  final LoadingStatus statusUpdate;
  final NoteEntity? note;

  const NoteCreateFirebaseSate({
    this.statusAdd = LoadingStatus.init,
    this.statusGet = LoadingStatus.init,
    this.statusUpdate = LoadingStatus.init,
    this.note,
  });

  @override
  List<Object?> get props => [
        statusAdd,
        statusGet,
        statusUpdate,
        note,
      ];

  NoteCreateFirebaseSate copyWith({
    LoadingStatus? statusAdd,
    LoadingStatus? statusGet,
    LoadingStatus? statusUpdate,
    NoteEntity? note,
  }) {
    return NoteCreateFirebaseSate(
      statusAdd: statusAdd ?? this.statusAdd,
      statusGet: statusGet ?? this.statusGet,
      statusUpdate: statusUpdate ?? this.statusUpdate,
      note: note ?? this.note,
    );
  }
}
