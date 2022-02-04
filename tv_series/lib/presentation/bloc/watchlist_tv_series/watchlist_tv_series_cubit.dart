import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show GetWatchlistTvSeries;

part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvSeriesCubit(this.getWatchlistTvSeries)
      : super(WatchlistTvSeriesInitial());

  Future call() async {
    emit(const WatchlistTvSeriesLoading());
    final result = await getWatchlistTvSeries.execute();
    result.fold((l) => emit(WatchlistTvSeriesError(l.message)),
        (r) => emit(WatchlistTvSeriesResult(r)));
  }
}
