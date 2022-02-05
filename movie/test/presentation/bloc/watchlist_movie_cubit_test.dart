import 'package:bloc_test/bloc_test.dart';
import 'package:core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist_movies/watchlist_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMoviesCubit watchlistMoviesCubit;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesCubit = WatchlistMoviesCubit(mockGetWatchlistMovies);
  });

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
      'initial state',
      build: () => watchlistMoviesCubit,
      verify: (cubit) => expect(cubit.state, WatchlistMoviesInitial())
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'Should return list of movies when watchlisted',
    build: () => watchlistMoviesCubit,
    setUp: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
    },
    act: (bloc) => bloc(),
    expect: () => <WatchlistMoviesState>[
      const WatchlistMoviesLoading(),
      WatchlistMoviesResult(testMovieList)
    ],
  );

  blocTest<WatchlistMoviesCubit, WatchlistMoviesState>(
    'Should return error if error',
    build: () => watchlistMoviesCubit,
    setUp: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Unknown error occurred')));
    },
    act: (bloc) => bloc(),
    expect: () => <WatchlistMoviesState>[
      const WatchlistMoviesLoading(),
      WatchlistMoviesError('Unknown error occurred')
    ],
  );
}