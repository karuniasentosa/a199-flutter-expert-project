import 'package:dartz/dartz.dart';
import 'package:tv_series/usecases.dart' show RemoveWatchlistTvSeries;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mockhelper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late RemoveWatchlistTvSeries removeWatchlistTvSeries;

  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    removeWatchlistTvSeries = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should return success(true) when watchlist successfully removed', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlist(2))
        .thenAnswer((_) async => Right(true));

    // act
    final result = removeWatchlistTvSeries.execute(2);

    // assert
    expect(await result, Right(true));
  });
}