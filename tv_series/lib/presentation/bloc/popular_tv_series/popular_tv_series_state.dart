part of 'popular_tv_series_cubit.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();
}

class PopularTvSeriesInitial extends PopularTvSeriesState {
  @override
  List<Object> get props => [];
}

class PopularTvSeriesLoading extends PopularTvSeriesState {
  const PopularTvSeriesLoading();

  @override
  List<Object?> get props => [];
}

class PopularTvSeriesResult extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  const PopularTvSeriesResult(this.tvSeries);

  @override
  List<Object?> get props => [];
}

class PopularTvSeriesError extends PopularTvSeriesState {
  final String errorMessage;

  const PopularTvSeriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}