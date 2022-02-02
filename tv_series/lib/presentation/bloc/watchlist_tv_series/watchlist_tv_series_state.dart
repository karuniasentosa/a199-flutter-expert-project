part of 'watchlist_tv_series_cubit.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();
}

class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {
  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {
  const WatchlistTvSeriesLoading();

  @override
  List<Object?> get props => [];
}

class WatchlistTvSeriesResult extends WatchlistTvSeriesState {
  final List<TvSeries> tvSeries;

  const WatchlistTvSeriesResult(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String errorMessage;

  const WatchlistTvSeriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}