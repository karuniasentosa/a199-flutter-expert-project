part of 'top_rated_movies_cubit.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();
}

class TopRatedMoviesInitial extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  const TopRatedMoviesLoading();

  @override
  List<Object?> get props => [];
}

class TopRatedMoviesResult extends TopRatedMoviesState {
  final List<Movie> movies;

  const TopRatedMoviesResult(this.movies);

  @override
  List<Object?> get props => [movies];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String errorMessage;

  const TopRatedMoviesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}