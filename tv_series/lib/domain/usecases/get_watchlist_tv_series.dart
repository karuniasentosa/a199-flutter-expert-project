import 'package:dartz/dartz.dart';
import '../../../../core/lib/common/failure.dart';
import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';

class GetWatchlistTvSeries {
  final TvSeriesRepository tvSeriesRepository
  ;

  GetWatchlistTvSeries(this.tvSeriesRepository);

  Future<Either<DatabaseFailure, List<TvSeries>>> execute() async {
    return tvSeriesRepository.getWatchlistTvSeries();
  }
}