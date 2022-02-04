import 'package:core/exception.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

import '../datasources/tv_series_local_data_source.dart';
import '../datasources/tv_series_remote_data_source.dart';
import '../models/tv_series_model.dart';

class TvSeriesRepositoryImpl extends TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;

  TvSeriesRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(List.from(result.map((e) => e.toEntity())));
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(List.from(result.map((e) => e.toEntity())));
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvSeries();
      return Right(List.from(result.map((e) => e.toEntity())));
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(
      {required int id}) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id: id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(
      {required int id}) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendations(id: id);
      return Right(List.from(result.map((e) => e.toEntity())));
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(
      {required String query}) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query: query);
      return Right(List.from(result.map((e) => e.toEntity())));
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> insertWatchlist(
      TvSeriesDetail tvSeries) async {
    try {
      final result = await localDataSource
          .insertWatchlist(TvSeriesModel.fromTvSeriesDetail(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> getWatchlistStatus(int tvId) async {
    try {
      final result = await localDataSource.getWatchlistStatus(tvId);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<DatabaseFailure, bool>> removeWatchlist(int tvId) async {
    try {
      final result = await localDataSource.removeWatchlist(tvId);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<DatabaseFailure, List<TvSeries>>> getWatchlistTvSeries() async {
    try {
      final result = await localDataSource.getAllWatchlist();
      final list = result.map((e) => e.toEntity()).toList();
      return Right(list);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
