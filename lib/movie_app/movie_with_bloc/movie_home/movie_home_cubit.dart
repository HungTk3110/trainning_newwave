import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_newwave/model/enums/loading_status.dart';
import 'package:training_newwave/model/popular_entity.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

part 'movie_home_state.dart';

class MovieHomeCubit extends Cubit<MovieHomeState> {
  MovieHomeCubit() : super(const MovieHomeState());

  Future<void> initData() async {
    emit(
      state.copyWith(
        loadingStatus: LoadingStatus.loading,
      ),
    );
    try {
      final response = await ApiService.fetchPopular();

      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.success,
          popular: response,
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
