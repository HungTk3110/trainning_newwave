part of 'note_search_isar_cubit.dart';

class NoteSearchIsarSate extends Equatable {
  final LoadingStatus loadingStatus;
  final List<NoteIsarEntity>? listNote;

  const NoteSearchIsarSate({
    this.loadingStatus = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        listNote,
      ];

  NoteSearchIsarSate copyWith({
    LoadingStatus? loadingStatus,
    List<NoteIsarEntity>? listNote,
  }) {
    return NoteSearchIsarSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
