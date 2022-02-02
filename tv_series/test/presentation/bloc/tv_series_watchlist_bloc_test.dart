import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/watchlist_bloc/tv_series_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockInsertWatchlistTvSeries mockInsertWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;

  setUp(() {
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockInsertWatchlistTvSeries = MockInsertWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();

    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      getWatchlistTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
      insertWatchlistTvSeries: mockInsertWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  // All state shall be under [TvSeriesWatchlistState]
  group('get watchlist status', () {
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return true if usecase says true',
      setUp: () {
        when(mockGetWatchlistTvSeriesStatus.execute(tvId: 2))
            .thenAnswer((_) async => const Right(true));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(const WatchlistStatusGet(2)),
      expect: () => [
        const TvSeriesWatchlistStatusResult(true),
      ]
    );
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        'should return error when usecase returns error',
        setUp: () {
          when(mockGetWatchlistTvSeriesStatus.execute(tvId: 2))
              .thenAnswer((_) async => Left(DatabaseFailure('asdf')));
        },
        build: () => tvSeriesWatchlistBloc,
        act: (bloc) => bloc.add(const WatchlistStatusGet(2)),
        expect: () => [
          const TvSeriesWatchlistStatusError('asdf'),
        ]
    );
  });

  group('insert tv series to watchlist', () {
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return true when successfully added to watchlist',
      setUp: () {
        when(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(true));
        when(mockInsertWatchlistTvSeries.execute(tTvSeriesDetail))
            .thenAnswer((_) async => const Right(true));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(WatchlistInsert(tTvSeriesDetail)),
      expect: () => [
        isA<InsertWatchlistSuccess>(),
        const TvSeriesWatchlistStatusResult(true)
      ]
    );
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return errror',
      setUp: () {
        when(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(false));
        when(mockInsertWatchlistTvSeries.execute(tTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('error: true')));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(WatchlistInsert(tTvSeriesDetail)),
      expect: () => [
        isA<InsertWatchlistError>(),
        const TvSeriesWatchlistStatusResult(false)
      ]
    );
  });

  group('remove from watchlist', () {
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
      'should return success',
      setUp: () {
        when(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id))
            .thenAnswer((_) async => const Right(false));
        when(mockRemoveWatchlistTvSeries.execute(2))
            .thenAnswer((_) async => const Right(true));
      },
      build: () => tvSeriesWatchlistBloc,
      act: (bloc) => bloc.add(const WatchlistRemove(2)),
      expect: () => [
        isA<RemoveWatchlistSuccess>(),
        const TvSeriesWatchlistStatusResult(false)
      ]
    );
    blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        'should return errror',
        setUp: () {
          when(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id))
              .thenAnswer((_) async => const Right(true));
          when(mockRemoveWatchlistTvSeries.execute(2))
              .thenAnswer((_) async => Left(DatabaseFailure('error: true')));
        },
        build: () => tvSeriesWatchlistBloc,
        act: (bloc) => bloc.add(const WatchlistRemove(2)),
        expect: () => [
          isA<RemoveWatchlistError>(),
          const TvSeriesWatchlistStatusResult(true)
        ]
    );
  });
}