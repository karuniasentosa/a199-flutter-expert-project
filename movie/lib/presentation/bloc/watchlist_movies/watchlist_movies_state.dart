part of 'watchlist_movies_cubit.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();
}

class WatchlistMoviesInitial extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  const WatchlistMoviesLoading();

  @override
  List<Object?> get props => [];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String errorMessage;

  const WatchlistMoviesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class WatchlistMoviesResult extends WatchlistMoviesState {
  final List<Movie> movies;

  const WatchlistMoviesResult(this.movies);

  @override
  List<Object?> get props => [movies];
}