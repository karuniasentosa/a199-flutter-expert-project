import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries, GetTopRatedTvSeries, GetNowPlayingTvSeries])
void main() {
  late TvSeriesListNotifier notifier;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedMovies;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  int notifyCount = 0xdeadbeef;

  setUp((){
    notifyCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedMovies = MockGetTopRatedTvSeries();
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = TvSeriesListNotifier(
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedMovies,
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
    )..addListener(() { notifyCount++; });
  });

  final tvSeriesList = <TvSeries>[
    TvSeries(
        id: 4,
        name: 'Name',
        overview: 'o',
        posterPath: '/b.jpg'),
  ];

  group('popular tv Series', () {
    test('initialState should be empty', () {
      expect(notifier.popularTvSeriesState, RequestState.Empty);
    });
    test('ResultState should be empty when given empty response', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(<TvSeries>[]));
      // act
      await notifier.fetchPopularTvSeries();

      // assert
      expect(notifier.popularTvSeriesState, RequestState.Empty);
      expect(notifyCount, 2);
    });
    test('ResultState should be Loaded when data is available', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      // act
      await notifier.fetchPopularTvSeries();

      // assert
      expect(notifier.popularTvSeriesState, RequestState.Loaded);
      expect(notifyCount, 2);
      expect(notifier.popularTvSeriesList, tvSeriesList);
    });
    test('Should return an error when something occured', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Could not contact to server')));

      // act
      await notifier.fetchPopularTvSeries();

      // assert
      expect(notifier.popularTvSeriesState, RequestState.Error);
      expect(notifyCount, 2);
      expect(notifier.popularTvSeriesErrorMessage, 'Could not contact to server');
    });
  });

  group('top rated tv series', () {
    test('initial topRatedTvState should be Empty', () {
      expect(notifier.topRatedTvSeriesState, RequestState.Empty);
    });
    test('RequestState should be empty when given response is empty', () async {
      // arrataraarnarnaratartanrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(<TvSeries>[]));

      // act
      await notifier.fetchTopRatedTvSeries();

      // assert
      expect(notifier.topRatedTvSeriesState, RequestState.Empty);
      expect(notifyCount, 2);
    });
    test('RequestState should be Loaded when there is an tv series', () async {
      // arang
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      // act
      await notifier.fetchTopRatedTvSeries();

      // assert
      expect(notifier.topRatedTvSeriesState, RequestState.Loaded);
      expect(notifier.topRatedTvSeriesList, tvSeriesList);
      expect(notifyCount, 2);
    });
    test('should state to Error when failure happens', () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('a failure at heart')));

      // act
      await notifier.fetchTopRatedTvSeries();

      // assert
      expect(notifier.topRatedTvSeriesState, RequestState.Error);
      expect(notifier.topRatedTvSeriesErrorMessage, 'a failure at heart');
    });
  });

  group('now playing tv series', () {
    test('initial state of nowPlayingTvSeriesState should be Empty', (){
      expect(notifier.nowPlayingTvSeriesState, RequestState.Empty);
    });
    test('RequestState should return error when ... error .... ... .uhh      occured.', () async {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async =>
          Left(
              ServerFailure('The request could not be made.')));

      // act
      await notifier.fetchNowPlayingTvSeries();

      // assert
      expect(notifier.nowPlayingTvSeriesState, RequestState.Error);
      expect(notifier.nowPlayingTvSeriesErrorMessage, 'The request could not be made.');
      expect(notifier.nowPlayingTvSeriesList, []);
      expect(notifyCount, 2);
    });
    test('RequestState should be Loaded when data is available', () async {
      // ara ara kimochi
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tvSeriesList));

      // act
      await notifier.fetchNowPlayingTvSeries();

      // assert
      expect(notifier.nowPlayingTvSeriesState, RequestState.Loaded);
      expect(notifyCount, 2);
    });
    test('RequestState should be Empty when no data is retrieved', () async {
      // arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right([]));

      // act
      final result = notifier.fetchNowPlayingTvSeries();
      expect(notifier.nowPlayingTvSeriesState, RequestState.Loading);
      await result;
      // assert
      expect(notifier.nowPlayingTvSeriesState, RequestState.Empty);
      expect(notifyCount, 2);
    });
  });
}