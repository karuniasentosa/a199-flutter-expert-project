import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show GetTvSeriesRecommendation;

part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationCubit extends Cubit<TvSeriesRecommendationState> {
  final GetTvSeriesRecommendation getTvSeriesRecommendation;

  TvSeriesRecommendationCubit(this.getTvSeriesRecommendation)
      : super(TvSeriesRecommendationInitial());

  Future call(int tvId) async {
    emit(const TvSeriesRecommendationLoading());
    final result = await getTvSeriesRecommendation.execute(tvId);

    result.fold((failure) => emit(TvSeriesRecommendationError(failure.message)),
        (tvSeries) => emit(TvSeriesRecommendationResult(tvSeries)));
  }
}
