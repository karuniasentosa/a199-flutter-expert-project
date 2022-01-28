import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show DatabaseFailure;
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository
  ;

  GetWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, List<TvSeries>>> execute() async {
    return tvSeriesRepository.getWatchlistTvSeries();
  }
}