import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app_with_sqlite/database/note_database_helper.dart';

part 'note_detail_state.dart';

class NoteDetailCubit extends Cubit<NoteDetailSate> {
  NoteDetailCubit() : super(const NoteDetailSate());

  final dbHelper = NoteDatabaseHelper.instance;

  Future<void> getNote(int id) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await dbHelper.getNote(id);

      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.success,
          note: response,
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
