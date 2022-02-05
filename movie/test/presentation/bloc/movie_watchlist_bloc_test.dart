import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasemock.mocks.dart';

void main() {
  late MovieWatchlistBloc movieWatchlistBloc;

  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();

    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchlistStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const int movieId = 102;

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'initial state',
    build: () => movieWatchlistBloc,
    verify: (cubit) => expect(cubit.state, MovieWatchlistInitial())
  );

  group('get watchlist status', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return false when usecase said false',
      setUp: () {
        when(mockGetWatchListStatus.execute(movieId))
            .thenAnswer((realInvocation) async => false);
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(const WatchlistStatusGet(movieId)),
      expect: () => [
        const MovieWatchlistStatus(false)
      ]
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should return true when usecase said true',
        setUp: () {
          when(mockGetWatchListStatus.execute(movieId))
              .thenAnswer((realInvocation) async => true);
        },
        build: () => movieWatchlistBloc,
        act: (bloc) => bloc.add(const WatchlistStatusGet(movieId)),
        expect: () => [
          const MovieWatchlistStatus(true)
        ]
    );
  });

  group('save watchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return success message from usecase',
      setUp: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Successfully added to watchlist'));
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(WatchlistInsert(testMovieDetail)),
      expect: () => [
        isA<MovieInsertWatchlistSuccess>(),
        const MovieWatchlistStatus(true),
      ]
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should return failure message from usecase',
        setUp: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('I forgot the password to open it :)')));
        },
        build: () => movieWatchlistBloc,
        act: (bloc) => bloc.add(WatchlistInsert(testMovieDetail)),
        expect: () => [
          isA<MovieInsertWatchlistError>(),
          const MovieWatchlistStatus(false)
        ]
    );
  });

  group('remove watchlist', () {
    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should return success message from usecase',
      setUp: () {
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Successfully removed from watchlist'));
      },
      build: () => movieWatchlistBloc,
      act: (bloc) => bloc.add(WatchlistRemove(testMovieDetail)),
      expect: () => [
        isA<MovieRemoveWatchlistSuccess>(),
        const MovieWatchlistStatus(false)
      ]
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
        'should return fail message from usecase',
        setUp: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Successfully removed from watchlist')));
        },
        build: () => movieWatchlistBloc,
        act: (bloc) => bloc.add(WatchlistRemove(testMovieDetail)),
        expect: () => [
          isA<MovieRemoveWatchlistError>(),
          const MovieWatchlistStatus(true)
        ]
    );
  });

}