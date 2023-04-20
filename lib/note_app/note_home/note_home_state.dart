part of 'note_home_cubit.dart';

class NoteHomeSate extends Equatable {
  final LoadingStatus statusLoadAll;
  final LoadingStatus statusDelete;
  final List<NoteEntity>? listNote;

  const NoteHomeSate({
    this.statusLoadAll = LoadingStatus.init,
    this.statusDelete = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
    statusLoadAll,
    statusDelete,
    listNote,
  ];

  NoteHomeSate copyWith({
    LoadingStatus? statusLoadAll,
    LoadingStatus? statusDelete ,
    List<NoteEntity>? listNote,
  }) {
    return NoteHomeSate(
      statusLoadAll: statusLoadAll ?? this.statusLoadAll,
      statusDelete: statusDelete ?? this.statusDelete,
      listNote: listNote ?? this.listNote,
    );
  }
}
