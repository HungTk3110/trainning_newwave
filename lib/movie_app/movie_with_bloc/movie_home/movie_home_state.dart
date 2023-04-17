part of 'movie_home_cubit.dart';

class MovieHomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final Popular? popular;

  const MovieHomeState({
    this.loadingStatus = LoadingStatus.init,
    this.popular,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        popular,
      ];

  MovieHomeState copyWith({
    LoadingStatus? loadingStatus,
    Popular? popular,
  }) {
    return MovieHomeState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      popular: popular ?? this.popular,
    );
  }
}
