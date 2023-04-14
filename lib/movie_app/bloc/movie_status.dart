import 'package:equatable/equatable.dart';
import 'package:training_newwave/model/popular_entity.dart';

enum PostStatus { initial, success, failure }

class MovieState extends Equatable {
  const MovieState({
    this.status = PostStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;

  MovieState copyWith({
    PostStatus status,
    List<Movie> movies,
    bool hasReachedMax,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${movies.length} }''';
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax];
}