import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesCubit popularTvSeriesCubit;

  setUp((){
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesCubit = PopularTvSeriesCubit(mockGetPopularTvSeries);
  });

  const a = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaa';

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'Should return popular tv series from internet',
      setUp: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesRecommendation));
      },
      build: () => popularTvSeriesCubit,
      act: (cubit) => cubit(),
      expect: () => [
        const PopularTvSeriesLoading(),
        PopularTvSeriesResult(tTvSeriesRecommendation),
      ]
  );

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'Should return eerror when erorr',
      setUp: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure(a)));
      },
      build: () => popularTvSeriesCubit,
      act: (cubit) => cubit(),
      expect: () => [
        const PopularTvSeriesLoading(),
        const PopularTvSeriesError(a),
      ]
  );

}