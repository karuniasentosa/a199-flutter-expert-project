import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesCubit topRatedTvSeriesCubit;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesCubit = TopRatedTvSeriesCubit(mockGetTopRatedTvSeries);
  });

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'should return list of top rated movies',
    setUp: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async  => Right(tTvSeriesRecommendation));
    },
    build: () => topRatedTvSeriesCubit,
    act: (cubit) => cubit(),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesResult(tTvSeriesRecommendation)
    ]
  );

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'should return error from usecase',
    setUp: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => topRatedTvSeriesCubit,
    act: (cubit) => cubit(),
    expect: () => [
      const TopRatedTvSeriesLoading(),
      isA<TopRatedTvSeriesError>(),
    ]
  );
}