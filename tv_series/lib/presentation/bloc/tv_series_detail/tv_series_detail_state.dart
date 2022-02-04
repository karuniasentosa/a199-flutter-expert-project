part of 'tv_series_detail_cubit.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();
}

class TvSeriesDetailInitial extends TvSeriesDetailState {
  @override
  List<Object> get props => [];
}

class TvSeriesDetailLoading extends TvSeriesDetailState {
  const TvSeriesDetailLoading();

  @override
  List<Object?> get props => [];
}

class TvSeriesDetailResult extends TvSeriesDetailState {
  final TvSeriesDetail tvSeriesDetail;

  const TvSeriesDetailResult(this.tvSeriesDetail);

  @override
  List<Object?> get props => [tvSeriesDetail];
}

class TvSeriesDetailError extends TvSeriesDetailState {
  final String errorMessage;

  const TvSeriesDetailError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
