import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/popular_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_popular_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvSeriesNotifier notifier;
  int notifiedCount = 0xdeadbeef;

  setUp((){
    notifiedCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    notifier = PopularTvSeriesNotifier(mockGetPopularTvSeries)
      ..addListener(() {
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

  test('should change state to loading when usecase is used', () async {
    // arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    // act
    notifier.fetchPopularTvSeries();

    expect(notifier.state, RequestState.Loading);
    expect(notifiedCount, 1);
  });

  test('should change state to loaded when data is loaded', () async {
    // arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));

    // act
    await notifier.fetchPopularTvSeries();

    // assert
    expect(notifiedCount, 2);
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tTvSeriesList);
  });

  test('should reutrn error when error occurred (obvs.)', () async {
    // arrange
    when(mockGetPopularTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('No connection could be made')));

    // act
    await notifier.fetchPopularTvSeries();

    expect(notifiedCount, 2);
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'No connection could be made');
  });
}