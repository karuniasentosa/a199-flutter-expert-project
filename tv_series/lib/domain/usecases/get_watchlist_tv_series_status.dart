import 'package:dartz/dartz.dart';
import '../../../../core/lib/common/failure.dart';
import '../repositories/tv_series_repository.dart';

class GetWatchlistTvSeriesStatus {
  final TvSeriesRepository tvSeriesRepository;

  GetWatchlistTvSeriesStatus(this.tvSeriesRepository);

  Future<Either<Failure, bool>> execute({required int tvId}) {
    return tvSeriesRepository.getWatchlistStatus(tvId);
  }
}