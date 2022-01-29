import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart';

void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(mockGetMovieDetail);
  });

  const tId = 1;

  blocTest<MovieDetailCubit, MovieDetailState>(
      'Should return a result with movie detail',
      setUp: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((realInvocation) async => Right(testMovieDetail));
      },
      build: () => movieDetailCubit,
      act: (cubit) => cubit(tId),
      expect: () => [
        const MovieDetailLoading(),
        MovieDetailResult(testMovieDetail)
      ]
  );

  blocTest<MovieDetailCubit, MovieDetailState>(
    'Should return error when something happen',
    setUp: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((realInvocation) async => Left(ConnectionFailure('No connection could be made')));
    },
    build: () => movieDetailCubit,
    act: (cubit) => cubit(tId),
    expect: () => [
      const MovieDetailLoading(),
      const MovieDetailError('No connection could be made')
    ]
  );
}