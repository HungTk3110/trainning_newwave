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
        statusAdd: LoadingStatus.loading,
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
          statusAdd: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusAdd: LoadingStatus.failure,
        ),
      );
    }
  }

  Future<void> getNote(int id) async {
    emit(
      state.copyWith(
        statusGet: LoadingStatus.loading,
      ),
    );

    try {
      // final response = await dbHelper.getNote(id);

      emit(
        state.copyWith(
          // note: response,
          statusGet: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusGet: LoadingStatus.failure,
        ),
      );
    }
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String describe,
    required int color,
  }) async {
    emit(
      state.copyWith(
        statusUpdate: LoadingStatus.loading,
      ),
    );

    try {
      // Map<String, dynamic> note = {
      //   NoteDatabaseHelper.columnId: id,
      //   NoteDatabaseHelper.columnTitle: title,
      //   NoteDatabaseHelper.columnDescribe: describe,
      //   NoteDatabaseHelper.columnColor: color
      // };

      // await dbHelper.updateNote(NoteEntity(
      //   id: id,
      //   title: title,
      //   describe: describe,
      //   color: color,
      // ).toDbMap());

      emit(
        state.copyWith(
          statusUpdate: LoadingStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          statusUpdate: LoadingStatus.failure,
        ),
      );
    }
  }
}
