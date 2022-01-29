part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();
}

class MovieWatchlistInitial extends MovieWatchlistState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistStatus extends MovieWatchlistState {
  final bool watchlisted;

  const MovieWatchlistStatus(this.watchlisted);

  @override
  List<Object?> get props => [watchlisted];
}

abstract class MovieRemoveWatchlistState extends MovieWatchlistState {
  final String message;
  const MovieRemoveWatchlistState(this.message);
}

class MovieRemoveWatchlistSuccess extends MovieRemoveWatchlistState {
  const MovieRemoveWatchlistSuccess(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

class MovieRemoveWatchlistError extends MovieRemoveWatchlistState {
  const MovieRemoveWatchlistError(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

abstract class MovieInsertWatchlistState extends MovieWatchlistState {
  final String message;
  const MovieInsertWatchlistState(this.message);
}

class MovieInsertWatchlistSuccess extends MovieInsertWatchlistState {
  const MovieInsertWatchlistSuccess(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

class MovieInsertWatchlistError extends MovieInsertWatchlistState {
  const MovieInsertWatchlistError(String message) : super(message);

  @override
  List<Object?> get props => [message];
}