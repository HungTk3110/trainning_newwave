part of 'note_edit_firebase_cubit.dart';

class NoteEditFirebaseSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingUpdateStatus;
  final NoteEntity? note;

  const NoteEditFirebaseSate({
    this.loadingStatus = LoadingStatus.init,
    this.loadingUpdateStatus = LoadingStatus.init,
    this.note,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        loadingUpdateStatus,
        note,
      ];

  NoteEditFirebaseSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingUpdateStatus,
    NoteEntity? note,
  }) {
    return NoteEditFirebaseSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingUpdateStatus: loadingUpdateStatus ?? this.loadingUpdateStatus,
      note: note ?? this.note,
    );
  }
}
