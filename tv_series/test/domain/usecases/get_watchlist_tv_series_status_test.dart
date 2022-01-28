import 'package:dartz/dartz.dart';
import 'package:core/failure.dart';
import 'package:tv_series/usecases.dart' show GetWatchlistTvSeriesStatus;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mockhelper.mocks.dart';

void main() {
  late GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getWatchlistTvSeriesStatus = GetWatchlistTvSeriesStatus(mockTvSeriesRepository);
  });

  test('should return boolean value when there exists watchlist with some id', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlistStatus(2))
        .thenAnswer((_) async => Right(false));

    // act
    final result = getWatchlistTvSeriesStatus.execute(tvId: 2);

    // assert
    expect(await result, Right(false));
  });

  test('should return failure when failure happens', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlistStatus(2))
        .thenAnswer((_) async => Left(DatabaseFailure('failed to fetch')));

    // act
    final result = getWatchlistTvSeriesStatus.execute(tvId: 2);

    // assert
    expect(await result, Left(DatabaseFailure('failed to fetch')));
  });
}