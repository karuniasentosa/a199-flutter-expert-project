import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_recommendations/movie_recommendations_cubit.dart';

import 'usecasemock.mocks.dart';

void main() {
  late MovieRecommendationsCubit movieRecommendationsCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  const tId = 1;
  final tMovies = [Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  )];

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsCubit = MovieRecommendationsCubit(mockGetMovieRecommendations);
  });

  blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
    'Initial state should return initial when no thing to do',
    build: () => movieRecommendationsCubit,
    verify: (cubit) => expect(cubit.state, const MovieRecommendationsInitial())
  );

  blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'Should return list of movie recommendations when cubit is executed',
      setUp: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
      },
      build: () => movieRecommendationsCubit,
      act: (cubit) => cubit(tId),
      expect: () => [
        const MovieRecommendationsLoading(),
        MovieRecommendationsResult(tMovies)
      ]
  );

  blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
    'Should return failure when there is a failure',
    setUp: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure("I am tired please give me 5 star")));
    },
    build: () => movieRecommendationsCubit,
    act: (cubit) => cubit(tId),
    expect: () => [
      const MovieRecommendationsLoading(),
      isA<MovieRecommendationsError>(),
    ]
  );
}