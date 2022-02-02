import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesCubit nowPlayingTvSeriesCubit;

  setUp((){
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesCubit = NowPlayingTvSeriesCubit(mockGetNowPlayingTvSeries);
  });

  blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
    'should return now playing tv series',
    setUp: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
    },
    build: () => nowPlayingTvSeriesCubit,
    act: (cubit) => cubit(),
    expect: () => [
      const NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesResult(tTvSeriesRecommendation)
    ]
  );

  blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      'should return error when error',
      setUp: () {
        when(mockGetNowPlayingTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('')));
      },
      build: () => nowPlayingTvSeriesCubit,
      act: (cubit) => cubit(),
      expect: () => <NowPlayingTvSeriesState>[
        const NowPlayingTvSeriesLoading(),
        const NowPlayingTvSeriesError('')
      ]
  );
}