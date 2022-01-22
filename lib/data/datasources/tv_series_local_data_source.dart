import 'package:ditonton/common/exception.dart' as common;
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:sqflite/sqflite.dart';

import 'db/database_helper.dart';

abstract class TvSeriesLocalDataSource {
  Future<bool> insertWatchlist(TvSeriesModel table);
  Future<bool> getWatchlistStatus(int tvId);
  Future<bool> removeWatchlist(int tvId);
  Future<List<TvSeriesModel>> getAllWatchlist();
}

class TvSeriesLocalDataSourceImpl extends TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<bool> insertWatchlist(TvSeriesModel table) async {
    try {
      final result = databaseHelper.insertTvSeriesWatchlist(table);
      if (await result == 1) {
        return true;
      }
      return false;
    } on DatabaseException catch (e) {
      throw common.DatabaseException(e.toString());
    }
  }

  Future<bool> getWatchlistStatus(int tvId) async {
    try {
      final result = databaseHelper.getTvSeriesWatchlistStatus(tvId);
      if (await result == 1) {
        return true;
      }
      return false;
    } on DatabaseException catch (e) {
      throw common.DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> removeWatchlist(int tvId) async {
    try {
      final result = databaseHelper.removeTvSeriesWatchlist(tvId: tvId);
      if (await result == 1) {
        return true;
      }
      return false;
    } on DatabaseException catch(e) {
      throw common.DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvSeriesModel>> getAllWatchlist() async {
    try {
      final result = await databaseHelper.getWatchlistTvSeries();
      return result.map((e) => TvSeriesModel.fromJsonMapDatabase(e)).toList();
    } on DatabaseException catch(e) {
      throw common.DatabaseException(e.toString());
    }
  }
}