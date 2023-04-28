part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final LoadingStatus loadingStatus;
  final List<Cast>? listCast;
  final DetailMovie? detailMovie;

  const MovieDetailState({
    this.loadingStatus = LoadingStatus.init,
    this.detailMovie,
    this.listCast,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        detailMovie,
        listCast,
      ];

  MovieDetailState copyWith({
    LoadingStatus? loadingStatus,
    DetailMovie? detailMovie,
    List<Cast>? listCast,
  }) {
    return MovieDetailState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      detailMovie: detailMovie ?? this.detailMovie,
      listCast: listCast ?? this.listCast,
    );
  }
}
