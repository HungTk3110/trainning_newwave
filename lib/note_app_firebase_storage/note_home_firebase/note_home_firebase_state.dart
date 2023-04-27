part of 'note_home_firebase_cubit.dart';

class NoteHomeFirebaseSate extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus loadingDeleteStatus;
  final List<NoteEntity>? listNote;

  const NoteHomeFirebaseSate({
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

  NoteHomeFirebaseSate copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? loadingDeleteStatus,
    List<NoteEntity>? listNote,
  }) {
    return NoteHomeFirebaseSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      loadingDeleteStatus: loadingDeleteStatus ?? this.loadingDeleteStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
