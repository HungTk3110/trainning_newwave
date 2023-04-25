part of 'note_create_isar_cubit.dart';

class NoteCreateIsarSate extends Equatable {
  final LoadingStatus loadingStatus;
  final NoteIsarEntity? note;

  const NoteCreateIsarSate({
    this.loadingStatus = LoadingStatus.init,
    this.note,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        note,
      ];

  NoteCreateIsarSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? statusGet,
    LoadingStatus? statusUpdate,
    NoteIsarEntity? note,
  }) {
    return NoteCreateIsarSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      note: note ?? this.note,
    );
  }
}
