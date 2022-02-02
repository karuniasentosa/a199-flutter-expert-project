part of 'now_playing_tv_series_cubit.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();
}

class NowPlayingTvSeriesInitial extends NowPlayingTvSeriesState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {
  const NowPlayingTvSeriesLoading();
  @override
  List<Object?> get props => [];
}

class NowPlayingTvSeriesResult extends NowPlayingTvSeriesState {
  final List<TvSeries> tvSeries;

  const NowPlayingTvSeriesResult(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final String errorMessage;

  const NowPlayingTvSeriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}