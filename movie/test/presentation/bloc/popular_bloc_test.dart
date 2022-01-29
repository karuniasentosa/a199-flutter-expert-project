import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart' show MockGetPopularMovies;

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesCubit popularMoviesCubit;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesCubit = PopularMoviesCubit(mockGetPopularMovies);
  });

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should return popular movies',
    setUp: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
    },
    build: () => popularMoviesCubit,
    act: (cubit) => cubit(),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesResult(testMovieList),
    ]
  );
}