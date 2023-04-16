import 'package:equatable/equatable.dart';
import 'package:training_newwave/model/autogenerated_entity.dart';
import 'package:training_newwave/model/detail_movie_entity.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final Autogenerated autogenerated;
  final DetailMovie detailMovie;

  const MovieDetailLoaded({
    this.autogenerated,
    this.detailMovie,
  });
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError({this.message});
}
