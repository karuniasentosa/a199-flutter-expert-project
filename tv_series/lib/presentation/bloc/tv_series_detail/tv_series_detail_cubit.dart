import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/usecases.dart' show GetTvSeriesDetail;

part 'tv_series_detail_state.dart';

class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailCubit(this.getTvSeriesDetail) : super(TvSeriesDetailInitial());

  Future call(int id) async {
    emit(const TvSeriesDetailLoading());

    final result = await getTvSeriesDetail.execute(id);

    result.fold((failure) => emit(TvSeriesDetailError(failure.message)),
        (tvSeriesDetail) => emit(TvSeriesDetailResult(tvSeriesDetail)));
  }
}
