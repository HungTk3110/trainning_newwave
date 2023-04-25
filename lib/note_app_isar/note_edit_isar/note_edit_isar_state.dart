part of 'note_edit_isar_cubit.dart';

class NoteEditIsarSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingStatusUpdate;
  final NoteIsarEntity? note;

  const NoteEditIsarSate({
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

  NoteEditIsarSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingStatusUpdate,
    NoteIsarEntity? note,
  }) {
    return NoteEditIsarSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingStatusUpdate: loadingStatusUpdate ?? this.loadingStatusUpdate,
      note: note ?? this.note,
    );
  }
}
