part of 'tv_series_recommendation_cubit.dart';

abstract class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();
}

class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {
  @override
  List<Object> get props => [];
}

class TvSeriesRecommendationLoading extends TvSeriesRecommendationState {
  const TvSeriesRecommendationLoading();

  @override
  List<Object?> get props => [];
}

class TvSeriesRecommendationResult extends TvSeriesRecommendationState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationResult(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class TvSeriesRecommendationError extends TvSeriesRecommendationState {
  final String errorMessage;

  const TvSeriesRecommendationError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}