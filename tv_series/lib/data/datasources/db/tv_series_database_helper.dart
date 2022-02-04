import 'package:sqflite/sqflite.dart';
import 'package:tv_series/data/models/tv_series_model.dart';

class TvSeriesDatabaseHelper {
  static const String _tblTvSeriesWatchList = 'tvSeries_watchlist';
  static TvSeriesDatabaseHelper? _instance;
  static Database? _database;

  TvSeriesDatabaseHelper._() {
    _instance = this;
  }

  factory TvSeriesDatabaseHelper() => _instance ??= TvSeriesDatabaseHelper._();

  Future<Database?> get database async => _database ??= await _initDb();

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath);
    return db;
  }

  Future<int> getTvSeriesWatchlistStatus(int tvId) async {
    final db = await database;
    final map = await db!.query(_tblTvSeriesWatchList,
        columns: ['id'], where: 'id = ?', whereArgs: [tvId]);
    if (map.isEmpty) {
      return 0;
    }
    return map.length;
  }

  Future<int> insertTvSeriesWatchlist(TvSeriesModel tvSeries) async {
    final db = await database;
    return await db!.insert(_tblTvSeriesWatchList, tvSeries.toJson());
  }

  Future<int> removeTvSeriesWatchlist({required int tvId}) async {
    final db = await database;
    return await db!
        .delete(_tblTvSeriesWatchList, where: 'id = ?', whereArgs: [tvId]);
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    return await db!.query(_tblTvSeriesWatchList);
  }
}
