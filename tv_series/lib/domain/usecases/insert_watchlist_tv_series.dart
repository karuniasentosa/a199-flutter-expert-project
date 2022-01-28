import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show DatabaseFailure;
import '../entities/tv_series_detail.dart';
import '../repositories/tv_series_repository.dart';

class InsertWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository;

  InsertWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, bool>> execute(TvSeriesDetail model) {
    return tvSeriesRepository.insertWatchlist(model);
  }
}