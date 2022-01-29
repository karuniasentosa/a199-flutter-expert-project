import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart' show MockGetTopRatedMovies;

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesCubit topRatedMovieCubit;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieCubit = TopRatedMoviesCubit(mockGetTopRatedMovies);
  });

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'should return a value when list is returned',
    setUp: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
    },
    build: () => topRatedMovieCubit,
    act: (cubit) => cubit(),
    expect: () => [
      const TopRatedMoviesLoading(),
      TopRatedMoviesResult(testMovieList)
    ]
  );

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
      'should return fail when usecase says so',
      setUp: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('task failed successfully')));
      },
      build: () => topRatedMovieCubit,
      act: (cubit) => cubit(),
      expect: () => [
        const TopRatedMoviesLoading(),
        const TopRatedMoviesError('task failed successfully')
      ]
  );
}