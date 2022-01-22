import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSourceImpl = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  final tTvSeriesModel = TvSeriesModel(
      id: 1, name: 'Name', overview: 'Overfiew', posterPath: '/a');

  group('insert watchlist', () {
    test('should return true when insert to database is successful', () async {
      // arrang
      when(mockDatabaseHelper.insertTvSeriesWatchlist(tTvSeriesModel))
          .thenAnswer((_) async => 1);

      // act
      final result = dataSourceImpl.insertWatchlist(tTvSeriesModel);

      // assert
      expect(await result, true);
    });

    test('should throw DatabaseException when insertion to database is somehow failed', () async {
      // arrage
      when(mockDatabaseHelper.insertTvSeriesWatchlist(tTvSeriesModel))
          .thenThrow(DatabaseException(''));

      // act
      final call = dataSourceImpl.insertWatchlist(tTvSeriesModel);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
      expect(() => call, throwsA(predicate((DatabaseException f) => f.message == '')));
    });
  });

  group('remove watchlist', () {
    test('should return true if there exists watchlist tvSeries id', () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(tvId: 2))
          .thenAnswer((_) async => 1);

      // act
      final result = dataSourceImpl.removeWatchlist(2);

      // assert
      expect(await result, true);
    });

    test('should throw exception DatabaseException when exception failed', () async {
      // arrage
      when(mockDatabaseHelper.removeTvSeriesWatchlist(tvId: tTvSeriesModel.id))
          .thenThrow(DatabaseException('aaaaa'));

      // act
      final call = dataSourceImpl.removeWatchlist(tTvSeriesModel.id);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
      expect(() => call, throwsA(predicate((DatabaseException f) => f.message == 'aaaaa')));
    });
  });

  group('get watchlist status', () {
    final tvId = 2;
    test('should return false value when fetching from database is succesful but the tv series havent been added to watchlist', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesWatchlistStatus(tvId))
          .thenAnswer((_) async => 0); // 0 means this tv series haven't been added to watchlist

      // act
      final result = dataSourceImpl.getWatchlistStatus(tvId);

      // assert
      expect(await result, false);
    });

    test('should return false value when fetching from database is succesful but the tv series have been added to watchlist', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesWatchlistStatus(tvId))
          .thenAnswer((_) async => 1);

      // act
      final result = dataSourceImpl.getWatchlistStatus(tvId);

      // assert
      expect(await result, true);
    });
  });

  group('get all tv series watchlist', () {
    test('should retrieve all tv series watchlist', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => tTvSeriesWatchlistMap);

      // act
      final result = dataSourceImpl.getAllWatchlist();

      // assert
      expect(await result, tTvSeriesModelWatchlist);
    });
    test('should return empty array when there is no watchlist exist', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => []);

      // act
      final result = dataSourceImpl.getAllWatchlist();

      // assert
      expect(await result, []);
    });
    test('should throw exception when exception happens', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenThrow(DatabaseException(' '));

      // act
      final result = dataSourceImpl.getAllWatchlist();

      // assert
      expect(() => result, throwsA(predicate((DatabaseException f) => f.message == ' ')));
    });
  });
}