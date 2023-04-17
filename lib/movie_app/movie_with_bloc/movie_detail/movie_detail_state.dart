part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final LoadingStatus loadingStatus;
  final Autogenerated? autogenerated;
  final DetailMovie? detailMovie;

  const MovieDetailState({
    this.loadingStatus = LoadingStatus.init,
    this.detailMovie,
    this.autogenerated,
  });

  @override
  List<Object?> get props => [
    loadingStatus,
    detailMovie,
    autogenerated,
  ];

  MovieDetailState copyWith({
    LoadingStatus? loadingStatus,
    DetailMovie? detailMovie,
    Autogenerated? autogenerated,
  }) {
    return MovieDetailState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      detailMovie: detailMovie ?? this.detailMovie ,
      autogenerated: autogenerated ?? this.autogenerated,
    );
  }
}
