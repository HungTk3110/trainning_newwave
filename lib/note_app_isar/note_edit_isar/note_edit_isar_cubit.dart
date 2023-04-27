import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_isar_entity.dart';
import 'package:training_newwave/note_app_isar/isar/isar_helper.dart';

part 'note_edit_isar_state.dart';

class NoteEditIsarCubit extends Cubit<NoteEditIsarSate> {
  NoteEditIsarCubit() : super(const NoteEditIsarSate());
  IsarHelper isarHelper = IsarHelper.instance;

  Future<void> getNote(Id id) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await isarHelper.getNoteById(id);

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
    required NoteIsarEntity note,
    required String title,
    required String describe,
    required int color,
  }) async {
    emit(
      state.copyWith(
        loadingUpdateStatus: LoadingStatus.loading,
      ),
    );

    try {
      await isarHelper.updateNote(
        note: note,
        title: title,
        describe: describe,
        color: color,
      );

      emit(
        state.copyWith(
          loadingUpdateStatus: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingUpdateStatus: LoadingStatus.failure,
        ),
      );
    }
  }
}
