import 'package:movie/data/models/movie_table.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabaseHelper {
  static const String _tblMovieWatchlist = 'movie_watchlist';
  static MovieDatabaseHelper? _instance;
  static Database? _database;

  MovieDatabaseHelper._() {
    _instance = this;
  }

  factory MovieDatabaseHelper() => _instance ??= MovieDatabaseHelper._();

  Future<Database?> get database async => _database ??= await _initDb();

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath);
    return db;
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }
}
