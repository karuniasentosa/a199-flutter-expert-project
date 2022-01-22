import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

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