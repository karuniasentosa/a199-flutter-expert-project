import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/search_movies/search_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart';

void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesCubit searchMoviesCubit;

  setUp((){
    mockSearchMovies = MockSearchMovies();
    searchMoviesCubit = SearchMoviesCubit(mockSearchMovies);
  });

  const shruggie = r'¯\_(ツ)_/¯';

  blocTest<SearchMoviesCubit, SearchMoviesState>(
      'Should return list of movies searched',
      setUp: () {
        when(mockSearchMovies.execute('Spiderman'))
            .thenAnswer((realInvocation) async => Right(testMovieList));
      },
      build: () => searchMoviesCubit,
      act: (cubit) => cubit('Spiderman'),
      expect: () => [
        const SearchMoviesLoading(),
        SearchMoviesResult(testMovieList)
      ]
  );

  blocTest<SearchMoviesCubit, SearchMoviesState>(
    'should return error...',
    setUp: () {
      when(mockSearchMovies.execute('Spiderman'))
          .thenAnswer((realInvocation) async => Left(ServerFailure(shruggie)));
    },
    build: () => searchMoviesCubit,
    act: (cubit) => cubit('Spiderman'),
    expect: () => [
      const SearchMoviesLoading(),
      const SearchMoviesError(shruggie)
    ]
  );
}