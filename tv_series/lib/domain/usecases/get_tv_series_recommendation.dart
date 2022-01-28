import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show Failure;
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesRecommendation {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendation(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendations(id: id);
  }
}