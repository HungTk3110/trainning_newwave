import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_isar_entity.dart';
import 'package:training_newwave/note_app_isar/isar/isar_helper.dart';

part 'note_create_isar_state.dart';

class NoteCreateIsarCubit extends Cubit<NoteCreateIsarSate> {
  NoteCreateIsarCubit() : super(const NoteCreateIsarSate());
  IsarHelper isarHelper = IsarHelper.instance;

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
      await isarHelper.insertNote(
        title: title,
        describe: describe,
        color: color,
      );

      emit(
        state.copyWith(
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
}
