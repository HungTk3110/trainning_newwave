import 'package:bloc/bloc.dart';
import 'package:training_newwave/movie_app/bloc/movie_event.dart';
import 'package:training_newwave/movie_app/bloc/movie_status.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(MovieState initialState) : super(const MovieState()) {
    on<MovieFetched>(
      _onMovieFetched,
    );
  }

  Future<void> _onMovieFetched(
    MovieFetched event,
    Emitter<MovieState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final movies = await ApiService.fetchPopular();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            movies: movies.results,
            hasReachedMax: false,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
