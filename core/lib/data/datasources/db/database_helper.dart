import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _tblMovieWatchlist = 'movie_watchlist';
  static const String _tblTvSeriesWatchList = 'tvSeries_watchlist';

  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._() {
    _databaseHelper = this;
    database;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE  $_tblMovieWatchlist (
          id INTEGER PRIMARY KEY,
          title TEXT,
          overview TEXT,
          posterPath TEXT
        );
    ''');
    await db.execute('''
        CREATE TABLE $_tblTvSeriesWatchList (
          id INTEGER PRIMARY KEY,
          name TEXT,
          overview TEXT,
          posterPath TEXT
        );
    ''');
  }
}
