import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart';

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesCubit nowPlayingCubit;

  setUp((){
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingCubit = NowPlayingMoviesCubit(mockGetNowPlayingMovies);
  });

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'initial state should be intiial',
    build: () => nowPlayingCubit,
    verify: (cubit) => expect(cubit.state, NowPlayingMoviesInitial())
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      'Should return list of movies when usecase is successful',
      setUp: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
      },
      build: () => nowPlayingCubit,
      act: (cubit) => cubit(),
      expect: () => [
        const NowPlayingMoviesLoading(),
        NowPlayingMoviesResult(testMovieList),
      ]
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'should return error when usecase said no',
    setUp: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => nowPlayingCubit,
    act: (cubit) => cubit(),
    expect: () => [
      const NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('')
    ]
  );
}