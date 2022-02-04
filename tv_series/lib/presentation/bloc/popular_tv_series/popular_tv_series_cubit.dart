import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show GetPopularTvSeries;

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesCubit(this.getPopularTvSeries)
      : super(PopularTvSeriesInitial());

  Future call() async {
    emit(const PopularTvSeriesLoading());
    final result = await getPopularTvSeries.execute();
    result.fold((failure) => emit(PopularTvSeriesError(failure.message)),
        (tvSeries) => emit(PopularTvSeriesResult(tvSeries)));
  }
}
