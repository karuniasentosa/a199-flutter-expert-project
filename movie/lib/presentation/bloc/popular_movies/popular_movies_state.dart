part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();
}

class PopularMoviesInitial extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();

  @override
  List<Object?> get props => [];
}

class PopularMoviesResult extends PopularMoviesState {
  final List<Movie> movies;

  const PopularMoviesResult(this.movies);

  @override
  List<Object?> get props => [movies];
}

class PopularMoviesError extends PopularMoviesState {
  final String errorMessage;

  const PopularMoviesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}