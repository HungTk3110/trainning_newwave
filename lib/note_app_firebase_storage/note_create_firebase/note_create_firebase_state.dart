part of 'note_create_firebase_cubit.dart';

class NoteCreateFirebaseSate extends Equatable {
  final LoadingStatus loadingStatus;
  final NoteEntity? note;

  const NoteCreateFirebaseSate({
    this.loadingStatus = LoadingStatus.init,
    this.note,
  });

  NoteCreateFirebaseSate copyWith({
    LoadingStatus? loadingStatus,
    NoteEntity? note,
  }) {
    return NoteCreateFirebaseSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [
    loadingStatus,
    note,
  ];
}
