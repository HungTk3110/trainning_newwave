part of 'movie_home_cubit.dart';

class MovieHomeState extends Equatable {
  final LoadingStatus loadingStatus;
  final int? currentPosTop;
  final int? currentPosBottom;
  final Popular? popular;

  const MovieHomeState({
    this.loadingStatus = LoadingStatus.init,
    this.currentPosTop = 0,
    this.currentPosBottom = 0,
    this.popular,
  });

  @override
  List<Object?> get props => [
        loadingStatus,
        popular,
        currentPosTop,
        currentPosBottom,
      ];

  MovieHomeState copyWith({
    LoadingStatus? loadingStatus,
    int? currentPosTop,
    int? currentPosBottom,
    Popular? popular,
  }) {
    return MovieHomeState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      currentPosTop: currentPosTop ?? this.currentPosTop,
      currentPosBottom: currentPosBottom ?? this.currentPosBottom,
      popular: popular ?? this.popular,
    );
  }
}
