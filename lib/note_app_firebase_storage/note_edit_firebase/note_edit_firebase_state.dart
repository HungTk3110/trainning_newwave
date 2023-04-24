part of 'note_edit_firebase_cubit.dart';

class NoteEditFirebaseSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingStatusUpdate;
  final NoteEntity? note;

  const NoteEditFirebaseSate({
    this.loadingStatus = LoadingStatus.init,
    this.loadingStatusUpdate = LoadingStatus.init,
    this.note,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        loadingStatusUpdate,
        note,
      ];

  NoteEditFirebaseSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingStatusUpdate,
    NoteEntity? note,
  }) {
    return NoteEditFirebaseSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingStatusUpdate: loadingStatusUpdate ?? this.loadingStatusUpdate,
      note: note ?? this.note,
    );
  }
}
