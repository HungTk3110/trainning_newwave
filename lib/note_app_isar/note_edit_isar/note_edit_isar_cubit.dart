import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app/database/note_database_helper.dart';
import 'package:training_newwave/note_app_firebase_storage/firebase/firebase_helper.dart';

part 'note_edit_isar_state.dart';

class NoteEditFirebaseCubit extends Cubit<NoteEditFirebaseSate> {
  NoteEditFirebaseCubit() : super(const NoteEditFirebaseSate());


  Future<void> getNote(String id) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await FireBaseHelper().getNoteById(id);

      emit(
        state.copyWith(
          note: response,
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

  Future<void> updateNote({
    required String id,
    required String title,
    required String describe,
    required int color,
  }) async {
    emit(
      state.copyWith(
        loadingStatusUpdate: LoadingStatus.loading,
      ),
    );

    try {
      await FireBaseHelper().updateNoteById( id,NoteEntity(
        id: id,
        title: title,
        describe: describe,
        color: color,
      ).toDbMap());

      emit(
        state.copyWith(
          loadingStatusUpdate: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingStatusUpdate: LoadingStatus.failure,
        ),
      );
    }
  }
}
