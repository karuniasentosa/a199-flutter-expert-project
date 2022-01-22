import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_series/insert_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late InsertWatchlistTvSeries insertWatchlistTvSeries;

  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    insertWatchlistTvSeries = InsertWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should save tv series to watchlist', () async {
    // arrange
    when(mockTvSeriesRepository.insertWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => Right(true));

    // act
    final result = insertWatchlistTvSeries.execute(tTvSeriesDetail);

    // assert
    expect(await result, Right(true));
  });

  test('should return failure when failure occurs', () async {
    // arrange
    when(mockTvSeriesRepository.insertWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('The database has been slained')));

    // act
    final result = insertWatchlistTvSeries.execute(tTvSeriesDetail);

    // assert
    expect(await result, Left(DatabaseFailure('The database has been slained')));
  });
}