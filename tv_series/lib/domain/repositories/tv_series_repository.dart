import 'package:dartz/dartz.dart';
import '../../../../core/lib/common/failure.dart';
import '../entities/tv_series.dart';
import '../entities/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail({required int id});
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations({required int id});
  Future<Either<Failure, List<TvSeries>>> searchTvSeries({required String query});

  Future<Either<DatabaseFailure, bool>> insertWatchlist(TvSeriesDetail tvSeries);
  Future<Either<DatabaseFailure, bool>> getWatchlistStatus(int tvId);
  Future<Either<DatabaseFailure, bool>> removeWatchlist(int tvId);
  Future<Either<DatabaseFailure, List<TvSeries>>> getWatchlistTvSeries();
}