part of 'note_home_isar_cubit.dart';

class NoteHomeIsarSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus deleteStatus;
  final List<NoteIsarEntity>? listNote;

  const NoteHomeIsarSate({
    this.loadingStatus = LoadingStatus.init,
    this.deleteStatus = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        deleteStatus,
        listNote,
      ];

  NoteHomeIsarSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? deleteStatus,
    List<NoteIsarEntity>? listNote,
  }) {
    return NoteHomeIsarSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
