import 'package:core/core.dart' show Failure;
import 'package:dartz/dartz.dart' show Either;

import '../repositories/tv_series_repository.dart';

class GetWatchlistTvSeriesStatus {
  final TvSeriesRepository tvSeriesRepository;

  GetWatchlistTvSeriesStatus(this.tvSeriesRepository);

  Future<Either<Failure, bool>> execute({required int tvId}) {
    return tvSeriesRepository.getWatchlistStatus(tvId);
  }
}
