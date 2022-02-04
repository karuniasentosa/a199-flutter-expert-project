part of 'top_rated_tv_series_cubit.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();
}

class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {
  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {
  const TopRatedTvSeriesLoading();

  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesResult extends TopRatedTvSeriesState {
  final List<TvSeries> tvSeries;

  const TopRatedTvSeriesResult(this.tvSeries);

  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String errorMessage;

  const TopRatedTvSeriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
