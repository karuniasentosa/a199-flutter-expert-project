part of 'search_tv_series_cubit.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();
}

class SearchTvSeriesInitial extends SearchTvSeriesState {
  @override
  List<Object> get props => [];
}

class SearchTvSeriesLoading extends SearchTvSeriesState {
  const SearchTvSeriesLoading();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesResult extends SearchTvSeriesState {
  final List<TvSeries> tvSeries;

  const SearchTvSeriesResult(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String errorMessage;

  const SearchTvSeriesError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
