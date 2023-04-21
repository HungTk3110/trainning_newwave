import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app/database/note_database_helper.dart';

part 'note_home_state.dart';

class NoteHomeCubit extends Cubit<NoteHomeSate> {
  NoteHomeCubit() : super(const NoteHomeSate());
  final dbHelper = NoteDatabaseHelper.instance;

  Future<void> getAllNote() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await dbHelper.queryAllNotes();

      emit(
        state.copyWith(
          listNote: response,
          loadingStatus: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }

  Future<void> deleteNote(int id) async {
    emit(
      state.copyWith(
        deleteStatus: LoadingStatus.loading,
      ),
    );

    try {
      await dbHelper.deleteNote(id);
      final response = await dbHelper.queryAllNotes();

      emit(
        state.copyWith(
          listNote: response,
          deleteStatus: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          deleteStatus: LoadingStatus.failure,
        ),
      );
    }
  }
}
