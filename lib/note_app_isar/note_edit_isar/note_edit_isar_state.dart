part of 'note_edit_isar_cubit.dart';

class NoteEditIsarSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingUpdateStatus;
  final NoteIsarEntity? note;

  const NoteEditIsarSate({
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

  NoteEditIsarSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingUpdateStatus,
    NoteIsarEntity? note,
  }) {
    return NoteEditIsarSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingUpdateStatus: loadingUpdateStatus ?? this.loadingUpdateStatus,
      note: note ?? this.note,
    );
  }
}
