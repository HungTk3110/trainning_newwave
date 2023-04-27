import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/note_entity.dart';
import 'package:training_newwave/note_app_firebase_storage/firebase/firebase_helper.dart';

part 'note_create_firebase_state.dart';

class NoteCreateFirebaseCubit extends Cubit<NoteCreateFirebaseSate> {
  NoteCreateFirebaseCubit() : super(const NoteCreateFirebaseSate());

  final firebaseHelper = FireBaseHelper();

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
      await firebaseHelper.addNote(
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
