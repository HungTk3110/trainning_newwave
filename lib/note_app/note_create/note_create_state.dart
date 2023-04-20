part of 'note_create_cubit.dart';

class NoteCreateSate extends Equatable {
  final LoadingStatus statusAdd;
  final LoadingStatus statusGet;
  final LoadingStatus statusUpdate;
  final NoteEntity? note;

  const NoteCreateSate({
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

  NoteCreateSate copyWith({
    LoadingStatus? statusAdd,
    LoadingStatus? statusGet,
    LoadingStatus? statusUpdate,
    NoteEntity? note,
  }) {
    return NoteCreateSate(
      statusAdd: statusAdd ?? this.statusAdd,
      statusGet: statusGet ?? this.statusGet,
      statusUpdate: statusUpdate ?? this.statusUpdate,
      note: note ?? this.note,
    );
  }
}
