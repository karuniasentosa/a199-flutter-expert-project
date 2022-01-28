import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show DatabaseFailure;
import '../repositories/tv_series_repository.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository;

  RemoveWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, bool>> execute(int tvId) {
    return tvSeriesRepository.removeWatchlist(tvId);
  }
}