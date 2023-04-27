part of 'note_home_isar_cubit.dart';

class NoteHomeIsarSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingDeleteStatus;
  final List<NoteIsarEntity>? listNote;

  const NoteHomeIsarSate({
    this.loadingStatus = LoadingStatus.init,
    this.loadingDeleteStatus = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        loadingDeleteStatus,
        listNote,
      ];

  NoteHomeIsarSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingDeleteStatus,
    List<NoteIsarEntity>? listNote,
  }) {
    return NoteHomeIsarSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingDeleteStatus: loadingDeleteStatus ?? this.loadingDeleteStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
