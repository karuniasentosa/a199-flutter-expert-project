import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail/tv_series_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvSeriesDetailCubit tvSeriesDetailCubit;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailCubit = TvSeriesDetailCubit(mockGetTvSeriesDetail);
  });

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'tvseriesdetailcubit should be initial',
    build: () => TvSeriesDetailCubit(mockGetTvSeriesDetail),
      verify: (cubit) => expect(cubit.state, TvSeriesDetailInitial())
  );

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should return correct tv series detail',
    setUp: () {
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
    },
    build: () => tvSeriesDetailCubit,
    act: (cubit) => cubit(2),
    expect: () => [
      const TvSeriesDetailLoading(),
      TvSeriesDetailResult(tTvSeriesDetail)
    ]
  );

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should return failure when fails',
    setUp: () {
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Left(ServerFailure('...')));
    },
    build: () => tvSeriesDetailCubit,
    act: (cubit) => cubit(2),
    expect: () => [
      const TvSeriesDetailLoading(),
      const TvSeriesDetailError('...')
    ]
  );
}