part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();
}

class WatchlistStatusGet extends TvSeriesWatchlistEvent {
  final int tvId;

  const WatchlistStatusGet(this.tvId);

  @override
  List<Object?> get props => [tvId];
}

class WatchlistInsert extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const WatchlistInsert(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class WatchlistRemove extends TvSeriesWatchlistEvent {
  final int tvId;

  const WatchlistRemove(this.tvId);

  @override
  List<Object?> get props => [tvId];
}
