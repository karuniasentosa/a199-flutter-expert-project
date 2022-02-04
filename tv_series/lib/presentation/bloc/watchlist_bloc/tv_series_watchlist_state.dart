part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();
}

class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {
  @override
  List<Object> get props => [];
}

/// An abstract class to define a state that contains watchlist status.
abstract class TvSeriesWatchlistStatus extends TvSeriesWatchlistState {
  const TvSeriesWatchlistStatus();
}

class TvSeriesWatchlistStatusResult extends TvSeriesWatchlistStatus {
  final bool watchlisted;

  const TvSeriesWatchlistStatusResult(this.watchlisted);

  @override
  List<Object?> get props => [watchlisted];
}

class TvSeriesWatchlistStatusError extends TvSeriesWatchlistStatus {
  final String errorMessage;

  const TvSeriesWatchlistStatusError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

/// An abstract class to define a state about insert watchlist.
abstract class TvSeriesInsertWatchlistState extends TvSeriesWatchlistState {
  const TvSeriesInsertWatchlistState();
}

class InsertWatchlistSuccess extends TvSeriesInsertWatchlistState {
  const InsertWatchlistSuccess();

  @override
  List<Object?> get props => [];
}

class InsertWatchlistError extends TvSeriesInsertWatchlistState {
  final String errorMessage;

  const InsertWatchlistError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

/// An abstract class to define a state about remove watchlist.
abstract class TvSeriesRemoveWatchlistState extends TvSeriesWatchlistState {
  const TvSeriesRemoveWatchlistState();
}

class RemoveWatchlistSuccess extends TvSeriesRemoveWatchlistState {
  const RemoveWatchlistSuccess();

  @override
  List<Object?> get props => [];
}

class RemoveWatchlistError extends TvSeriesRemoveWatchlistState {
  final String errorMessage;

  const RemoveWatchlistError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
