import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show GetTopRatedTvSeries;

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesCubit(this.getTopRatedTvSeries)
      : super(TopRatedTvSeriesInitial());

  Future call() async {
    emit(const TopRatedTvSeriesLoading());
    final result = await getTopRatedTvSeries.execute();
    result.fold((failure) => emit(TopRatedTvSeriesError(failure.message)),
        (tvSeries) => emit(TopRatedTvSeriesResult(tvSeries)));
  }
}
