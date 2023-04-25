import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_isar_entity.dart';
import 'package:training_newwave/note_app_isar/isar/isar_helper.dart';

part 'note_search_isar_state.dart';

class NoteSearchIsarCubit extends Cubit<NoteSearchIsarSate> {
  NoteSearchIsarCubit() : super(const NoteSearchIsarSate());
  IsarHelper isarHelper = IsarHelper.instance;

  Future<void> searchNote(String str) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await isarHelper.searchNotesByTitle(str);

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

  Future<void> clearSearch() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    emit(
      state.copyWith(
        listNote: [],
        loadingStatus: LoadingStatus.success,
      ),
    );
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.failure,
      ),
    );
  }
}
