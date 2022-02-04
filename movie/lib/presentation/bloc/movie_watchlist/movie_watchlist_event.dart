part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();
}

class WatchlistStatusGet extends MovieWatchlistEvent {
  final int movieId;

  const WatchlistStatusGet(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class WatchlistInsert extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const WatchlistInsert(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class WatchlistRemove extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const WatchlistRemove(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}
