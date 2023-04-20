part of 'note_detail_cubit.dart';


class NoteDetailSate extends Equatable {
  final LoadingStatus loadingStatus;
  final NoteEntity? note;

  const NoteDetailSate({
    this.loadingStatus = LoadingStatus.init,
    this.note,
  });

  @override
  List<Object?> get props => [
    loadingStatus,
    note,
  ];

  NoteDetailSate copyWith({
    LoadingStatus? loadingStatus,
    NoteEntity? note,
  }) {
    return NoteDetailSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      note: note ?? this.note,
    );
  }
}
