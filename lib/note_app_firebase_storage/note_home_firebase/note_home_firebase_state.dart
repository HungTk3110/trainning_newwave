part of 'note_home_firebase_cubit.dart';

class NoteHomeFirebaseSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus deleteStatus;
  final List<NoteEntity>? listNote;

  const NoteHomeFirebaseSate({
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

  NoteHomeFirebaseSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? deleteStatus,
    List<NoteEntity>? listNote,
  }) {
    return NoteHomeFirebaseSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
