import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesNotifier notifier;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    notifier = PopularMoviesNotifier(mockGetPopularMovies);
  });

  final tMovie = Movie(
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
  );

  final tMovieList = <Movie>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchPopularMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
  });
}