import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_isar_entity.dart';
import 'package:training_newwave/note_app_isar/isar/isar_helper.dart';

part 'note_home_isar_state.dart';

class NoteHomeIsarCubit extends Cubit<NoteHomeIsarSate> {
  NoteHomeIsarCubit() : super(const NoteHomeIsarSate());
  IsarHelper isarHelper = IsarHelper.instance;

  Future<void> getAllNote() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await isarHelper.getAllNote();

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

  Future<void> deleteNote(Id id) async {
    emit(
      state.copyWith(
        deleteStatus: LoadingStatus.loading,
      ),
    );

    try {
      await isarHelper.deleteNoteById(id);
      final response = await isarHelper.getAllNote();

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
