import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistTvSeriesCubit watchlistTvSeriesCubit;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesCubit = WatchlistTvSeriesCubit(mockGetWatchlistTvSeries);
  });

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should return intial state',
    build: () =>  WatchlistTvSeriesCubit(mockGetWatchlistTvSeries),
      verify: (cubit) => expect(cubit.state, WatchlistTvSeriesInitial())
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should return watchlisted tv series list',
    setUp: () => when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesWatchlist)),
    build: () => watchlistTvSeriesCubit,
    act: (cubit) => cubit(),
    expect: () => [
      const WatchlistTvSeriesLoading(),
      WatchlistTvSeriesResult(tTvSeriesWatchlist)
    ]
  );

  blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
    'should return error',
    setUp: () => when(mockGetWatchlistTvSeries.execute())
      .thenAnswer((_) async => Left(DatabaseFailure(':P'))),
    build: () => watchlistTvSeriesCubit,
    act: (cubit) => cubit(),
    expect: () => [
      const WatchlistTvSeriesLoading(),
      const WatchlistTvSeriesError(':P')
    ]
  );
}