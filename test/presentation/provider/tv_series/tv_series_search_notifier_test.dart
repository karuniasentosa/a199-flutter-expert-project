import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
main() {
  late TvSeriesSearchNotifier tvSeriesSearchNotifier;
  late MockSearchTvSeries mockSearchTvSeries;
  int notifiyCallCount = 0x10;

  final query = 'AAAAAAAAAAA';

  setUp(() {
    notifiyCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    tvSeriesSearchNotifier = TvSeriesSearchNotifier(mockSearchTvSeries)
        ..addListener((){notifiyCallCount++;});
  });

  test('initial state should be empty', () {
    expect(tvSeriesSearchNotifier.state, RequestState.Empty);
    expect(notifiyCallCount, 0);
  });

  test('should set state to Loaded when some data is loaded', () async {
    // arrange
    when(mockSearchTvSeries.execute(query))
        .thenAnswer((_) async => Right(tTvSeriesSearchResult));

    // act
    final future = tvSeriesSearchNotifier.doSearchTvSeries(query);
    expect(tvSeriesSearchNotifier.state, RequestState.Loading);
    await future;

    expect(tvSeriesSearchNotifier.state, RequestState.Loaded);
    expect(tvSeriesSearchNotifier.searchResultList, tTvSeriesSearchResult);
    expect(notifiyCallCount, 2);
  });

  test('should set state to empty again when received data is empty', () async {
    // arrange
    when(mockSearchTvSeries.execute(query))
        .thenAnswer((_) async => Right([]));

    // act
    final future = tvSeriesSearchNotifier.doSearchTvSeries(query);
    expect(tvSeriesSearchNotifier.state, RequestState.Loading);
    await future;

    expect(tvSeriesSearchNotifier.state, RequestState.Empty);
    expect(notifiyCallCount, 2);
  });

  test('should set state to error when error happens', () async {
    // arrange
    when(mockSearchTvSeries.execute(query))
        .thenAnswer((_) async => Left(ServerFailure('')));

    // act
    await tvSeriesSearchNotifier.doSearchTvSeries(query);

    // assert
    expect(tvSeriesSearchNotifier.state, RequestState.Error);
    expect(tvSeriesSearchNotifier.errorMessage, '');
  });

}
