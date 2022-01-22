import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/now_playing_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late NowPlayingTvSeriesNotifier notifier;
  int notifiedCount = 0xAAAAAAAAAAAA;

  setUp((){
    notifiedCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    notifier = NowPlayingTvSeriesNotifier(mockGetNowPlayingTvSeries)
        ..addListener((){
          notifiedCount++;
        });
  });

  final tTvSeries = TvSeries(
      posterPath: 'f.jpg',
      id: 90,
      name: 'Snownam',
      overview: 'overview',
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state should be empty', () {
    expect(notifier.state, RequestState.Empty);
  });

  test('should change state to loading when usecase is being executed', () {
    // arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Right([]));

    // act
    notifier.fetchNowPlayingTvSeries();

    // assert
    expect(notifier.state, RequestState.Loading);
    expect(notifiedCount, 1);
  });

  test('should change state to loaded when usecase is done executing', () async {
    // arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    // act
    await notifier.fetchNowPlayingTvSeries();

    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeriesList, tTvSeriesList);
    expect(notifiedCount, 2);
  });

  test('should change state to Empty when no data is fetched', () async {
    // arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Right([]));

    // act
    await notifier.fetchNowPlayingTvSeries();

    // assert
    expect(notifier.state, RequestState.Empty);
    expect(notifiedCount, 2);
  });

  test('hsould provide error message when error occuered', () async {
    // arrange
    when(mockGetNowPlayingTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Error occured')));

    // act
    await notifier.fetchNowPlayingTvSeries();

    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifiedCount, 2);
    expect(notifier.errorMessage, 'Error occured');
  });
}