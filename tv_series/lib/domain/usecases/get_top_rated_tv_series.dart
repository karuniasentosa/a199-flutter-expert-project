import 'package:core/core.dart' show Failure;
import 'package:dartz/dartz.dart' show Either;

import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
