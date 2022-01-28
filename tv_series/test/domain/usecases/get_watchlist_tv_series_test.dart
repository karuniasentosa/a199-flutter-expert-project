import 'package:dartz/dartz.dart';
import 'package:tv_series/usecases.dart' show GetWatchlistTvSeries;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

import 'mockhelper.mocks.dart';

void main() {
  late GetWatchlistTvSeries getWatchlistTvSeries;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    getWatchlistTvSeries = GetWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('ßhould get tv series watchlist', () async {
    // arrange
    when(mockTvSeriesRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(tTvSeriesWatchlist));

    // act
    final result = getWatchlistTvSeries.execute();

    // assert
    expect(await result, Right(tTvSeriesWatchlist));
  });
}