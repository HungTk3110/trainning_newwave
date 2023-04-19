import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app/database/note_database_helper.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteSate> {
  NoteCubit() : super(const NoteSate());
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
          loadingStatus: LoadingStatus.success,
          listNote: response,
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

  Future<void> addNote(
    String title,
    String describe,
    int color,
  ) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {

      Map<String, dynamic> note = {
        NoteDatabaseHelper.columnTitle: title,
        NoteDatabaseHelper.columnDescribe: describe,
        NoteDatabaseHelper.columnColor: color
      };

      await dbHelper.insertNote(note);

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
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      await dbHelper.deleteNote(id);
      final response = await dbHelper.queryAllNotes();

      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.success,
          listNote: response,
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
}
