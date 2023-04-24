import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app_firebase_storage/firebase/firebase_helper.dart';

part 'note_home_isar_state.dart';

class NoteHomeFirebaseCubit extends Cubit<NoteHomeFirebaseSate> {
  NoteHomeFirebaseCubit() : super(const NoteHomeFirebaseSate());

  Future<void> getAllNote() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );

    try {
      final response = await FireBaseHelper().getAllNote();

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

  Future<void> deleteNote(String id) async {
    emit(
      state.copyWith(
        deleteStatus: LoadingStatus.loading,
      ),
    );

    try {
      await FireBaseHelper().deleteNote(id);
      final response = await FireBaseHelper().getAllNote();

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
