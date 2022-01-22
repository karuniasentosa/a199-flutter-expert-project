import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class RemoveWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository;

  RemoveWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, bool>> execute(int tvId) {
    return tvSeriesRepository.removeWatchlist(tvId);
  }
}