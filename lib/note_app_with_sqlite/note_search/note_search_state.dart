part of 'note_search_cubit.dart';

class NoteSearchSate extends Equatable {
  final LoadingStatus loadingStatus;
  final List<NoteEntity>? listNote;

  const NoteSearchSate({
    this.loadingStatus = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        listNote,
      ];

  NoteSearchSate copyWith({
    LoadingStatus? loadingStatus,
    List<NoteEntity>? listNote,
  }) {
    return NoteSearchSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
