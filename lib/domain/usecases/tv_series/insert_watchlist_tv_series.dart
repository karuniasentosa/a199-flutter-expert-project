import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class InsertWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository;

  InsertWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, bool>> execute(TvSeriesDetail model) {
    return tvSeriesRepository.insertWatchlist(model);
  }
}