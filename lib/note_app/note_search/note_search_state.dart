part of 'note_search_cubit.dart';

class NoteSearchSate extends Equatable {
  final LoadingStatus statusLoadAll;
  final LoadingStatus statusDelete;
  final List<NoteEntity>? listNote;

  const NoteSearchSate({
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

  NoteSearchSate copyWith({
    LoadingStatus? statusLoadAll,
    LoadingStatus? statusDelete ,
    List<NoteEntity>? listNote,
  }) {
    return NoteSearchSate(
      statusLoadAll: statusLoadAll ?? this.statusLoadAll,
      statusDelete: statusDelete ?? this.statusDelete,
      listNote: listNote ?? this.listNote,
    );
  }
}
