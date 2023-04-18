part of 'note_cubit.dart';

class NoteSate extends Equatable {
  final LoadingStatus loadingStatus;
  final List<Map<String, dynamic>>? listNote;

  const NoteSate({
    this.loadingStatus = LoadingStatus.init,
    this.listNote,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        listNote,
      ];

  NoteSate copyWith({
    LoadingStatus? loadingStatus,
    List<Map<String, dynamic>>? listNote,
  }) {
    return NoteSate(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listNote: listNote ?? this.listNote,
    );
  }
}
