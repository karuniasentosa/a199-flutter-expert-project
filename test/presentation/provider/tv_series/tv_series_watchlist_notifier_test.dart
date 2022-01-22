import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
int main() {
  late TvSeriesWatchlistNotifier notifier;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp((){
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    notifier = TvSeriesWatchlistNotifier(
      getWatchlistTvSeries: mockGetWatchlistTvSeries
    );
  });

  test('initial stat of notifier should be empty', () => expect(notifier.state, RequestState.Empty));

  test('should set state to loading when data is fetching', () {
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesRecommendation));

    // act
    notifier.fetchWatchlistTvSeries();

    expect(notifier.state, RequestState.Loading);
  });

  test('should set state to Loaded when data is fetched', () async {
    // arrange
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesRecommendation));

    // act
    await  notifier.fetchWatchlistTvSeries();

    expect(notifier.state, RequestState.Loaded);
    expect(notifier.watchlists, tTvSeriesRecommendation);
  });

  test('shoudl set state to Empty when there exist no data', () async {
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Right([]));

    // act
    await  notifier.fetchWatchlistTvSeries();

    expect(notifier.state, RequestState.Empty);
  });

  test("should set state to error when erorr woccured", () async {
    // arrange
    when(mockGetWatchlistTvSeries.execute())
        .thenAnswer((_) async => Left(DatabaseFailure('no such table')));

    // act
    await notifier.fetchWatchlistTvSeries();

    expect(notifier.state, RequestState.Error);
    expect(notifier.errorMessage, 'no such table');
  });

  return 0;
}