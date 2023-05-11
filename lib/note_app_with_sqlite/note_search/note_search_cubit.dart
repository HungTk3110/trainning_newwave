import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app_with_sqlite/database/note_database_helper.dart';

part 'note_search_state.dart';

class NoteSearchCubit extends Cubit<NoteSearchSate> {
  NoteSearchCubit() : super(const NoteSearchSate());
  final dbHelper = NoteDatabaseHelper.instance;

  Future<void> searchNote(String str) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await dbHelper.searchNote(str);

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
