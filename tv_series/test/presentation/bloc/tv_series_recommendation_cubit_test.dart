import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_series_recommendation/tv_series_recommendation_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;
  late TvSeriesRecommendationCubit tvSeriesRecommendationCubit;

  setUp((){
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    tvSeriesRecommendationCubit = TvSeriesRecommendationCubit(mockGetTvSeriesRecommendation);
  });

  blocTest<TvSeriesRecommendationCubit, TvSeriesRecommendationState>(
    'should return recommendations from tv',
    setUp: () {
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
    },
    build: () => tvSeriesRecommendationCubit,
    act: (cubit) => cubit(2),
    expect: () => [
      const TvSeriesRecommendationLoading(),
      TvSeriesRecommendationResult(tTvSeriesRecommendation)
    ]
  );

  blocTest<TvSeriesRecommendationCubit, TvSeriesRecommendationState>(
      'should return error',
      setUp: () {
        when(mockGetTvSeriesRecommendation.execute(2))
            .thenAnswer((_) async => Left(ServerFailure('yes')));
      },
      build: () => tvSeriesRecommendationCubit,
      act: (cubit) => cubit(2),
      expect: () => [
        const TvSeriesRecommendationLoading(),
        const TvSeriesRecommendationError('yes')
      ]
  );
}