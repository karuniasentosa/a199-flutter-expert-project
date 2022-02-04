part of 'search_movies_cubit.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();
}

class SearchMoviesInitial extends SearchMoviesState {
  @override
  List<Object> get props => [];
}

class SearchMoviesLoading extends SearchMoviesState {
  const SearchMoviesLoading();

  @override
  List<Object?> get props => [];
}

class SearchMoviesError extends SearchMoviesState {
  final String errorMessage;

  const SearchMoviesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class SearchMoviesResult extends SearchMoviesState {
  final List<Movie> movies;

  const SearchMoviesResult(this.movies);

  @override
  List<Object?> get props => [movies];
}
