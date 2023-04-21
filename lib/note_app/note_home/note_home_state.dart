part of 'note_home_cubit.dart';

class NoteHomeSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus deleteStatus;
  final List<NoteEntity>? listNote;

  const NoteHomeSate({
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

  NoteHomeSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? deleteStatus,
    List<NoteEntity>? listNote,
  }) {
    return NoteHomeSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
