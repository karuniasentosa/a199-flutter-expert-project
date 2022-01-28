import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show Failure;
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class
    SearchTvSeries      {
  final       TvSeriesRepository repository;

  SearchTvSeries
      (this.repository);

  Future<Either<Failure, List<TvSeries>>>
  execute(String query) {
    return repository.searchTvSeries(query: query);
  }
}