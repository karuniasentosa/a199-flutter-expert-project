import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show GetNowPlayingTvSeries;

part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesCubit(this.getNowPlayingTvSeries)
      : super(NowPlayingTvSeriesInitial());

  Future call() async {
    emit(const NowPlayingTvSeriesLoading());
    final result = await getNowPlayingTvSeries.execute();
    result.fold((l) => emit(NowPlayingTvSeriesError(l.message)),
        (r) => emit(NowPlayingTvSeriesResult(r)));
  }
}
