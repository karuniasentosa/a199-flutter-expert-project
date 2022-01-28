import 'package:dartz/dartz.dart' show Either;
import 'package:core/core.dart' show Failure;
import '../entities/tv_series_detail.dart';
import '../repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id: id);
  }
}