part of 'note_search_firebase_cubit.dart';

class NoteSearchFirebaseSate extends Equatable {
  final LoadingStatus loadingStatus;
  final List<NoteEntity>? listNote;

  const NoteSearchFirebaseSate({
    this.loadingStatus = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        listNote,
      ];

  NoteSearchFirebaseSate copyWith({
    LoadingStatus? loadingStatus,
    List<NoteEntity>? listNote,
  }) {
    return NoteSearchFirebaseSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
