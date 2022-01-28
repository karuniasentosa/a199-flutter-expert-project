import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show Failure;
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetNowPlayingTvSeries {
  final TvSeriesRepository repository;

  GetNowPlayingTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getNowPlayingTvSeries();
  }
}