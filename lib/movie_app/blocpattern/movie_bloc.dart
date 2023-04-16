import 'package:bloc/bloc.dart';
import 'package:training_newwave/movie_app/blocpattern/movie_event.dart';
import 'package:training_newwave/movie_app/blocpattern/movie_status.dart';
import 'package:training_newwave/movie_app/networks/api_service.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieFetched>((event, emit) async {
      try {
        emit(
          MovieLoading(),
        );
        final popular = await ApiService.fetchPopular();
        emit(
          MovieLoaded(popular: popular),
        );
      } catch(e) {
        emit(
          MovieError(
              message: e.toString()),
        );
      }
    });
  }
}
