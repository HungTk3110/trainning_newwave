import 'package:equatable/equatable.dart';
import 'package:training_newwave/model/popular_entity.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final Popular popular;
  const MovieLoaded({this.popular});
}

class MovieError extends MovieState {
  final String message;
  const MovieError({this.message});
}