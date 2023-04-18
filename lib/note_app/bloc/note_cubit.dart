import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/note_app/database/database_helper.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteSate> {
  NoteCubit() : super(const NoteSate());

  Future<void> getAllNote() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      final response = await DatabaseHelper.getItems();

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

  Future<void> insertNote(
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
      await DatabaseHelper.createItem(title, describe, color);
      final response = await DatabaseHelper.getItems();

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

  Future<void> deleteNote(int id) async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      await DatabaseHelper.deleteItem(id);
      final response = await DatabaseHelper.getItems();

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
