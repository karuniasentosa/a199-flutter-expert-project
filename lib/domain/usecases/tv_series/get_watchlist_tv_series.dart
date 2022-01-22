import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository
  ;

  GetWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, List<TvSeries>>> execute() async {
    return tvSeriesRepository.getWatchlistTvSeries();
  }
}