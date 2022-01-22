import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/tv_series/insert_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendation,
  InsertWatchlistTvSeries,
  GetWatchlistTvSeriesStatus,
  RemoveWatchlistTvSeries
])
void main() {
  late TvSeriesDetailNotifier notifier;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;
  late MockInsertWatchlistTvSeries mockInsertWatchlistTvSeries;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp((){
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    mockInsertWatchlistTvSeries = MockInsertWatchlistTvSeries();
    mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();

    notifier = TvSeriesDetailNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommendation: mockGetTvSeriesRecommendation,
        insertWatchlistTvSeries: mockInsertWatchlistTvSeries,
        getWatchlistTvSeriesStatus: mockGetWatchlistTvSeriesStatus,
        removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  group('get tv series detail', () {
    test('should retrieve tv series detail data when executed', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesDetail)); // TV Series Detail
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
      when(mockGetWatchlistTvSeriesStatus.execute(tvId: 2))
          .thenAnswer((_) async => Right(false));// TV Series Recommendation

      // act
      await notifier.fetchTvSeriesDetail(2);

      // assert
      expect(notifier.tvSeriesDetailState, RequestState.Loaded);
      expect(notifier.tvSeriesDetail, tTvSeriesDetail);

      verify(mockGetTvSeriesRecommendation.execute(2));
      expect(notifier.tvSeriesRecommendationState, RequestState.Loaded);
      expect(notifier.tvSeriesRecommendationList, tTvSeriesRecommendation);
    });
    test('tvSeriesDetailState should state Error when fetchTvSeriesDetail return ServerFailure', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Left(ServerFailure('The server is busy')));
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));

      // act
      await notifier.fetchTvSeriesDetail(2);

      // assert
      verifyNever(mockGetTvSeriesRecommendation.execute(2));
      expect(notifier.tvSeriesRecommendationState, RequestState.Empty);
      expect(notifier.tvSeriesDetailState, RequestState.Error);
      expect(notifier.tvSeriesDetailErrorMessage, 'The server is busy');
    });
  });

  group('watchlist movies', (){
    test('should insert tv sereis watchlist', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));

      when(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id))
          .thenAnswer((_) async => Right(true));
      when(mockInsertWatchlistTvSeries.execute(tTvSeriesDetail))
          .thenAnswer((_) async => Right(true));

      // act
      await notifier.fetchTvSeriesDetail(2);
      await notifier.insertToWatchlist();

      // asserrt
      verify(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id));
      verify(mockGetTvSeriesDetail.execute(tTvSeriesDetail.id));
      expect(notifier.addedToWatchlist, true);
    });

    test('should get tv series watchlist status', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));
      when(mockGetWatchlistTvSeriesStatus.execute(tvId: 2))
          .thenAnswer((_) async => Right(false));

      // act
      await notifier.fetchTvSeriesDetail(2);
      await notifier.getWatchlistStatus();

      // assert
      expect(notifier.addedToWatchlist, false);
    });

    test('should removed from watchlist', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesDetail));
      when(mockGetTvSeriesRecommendation.execute(2))
          .thenAnswer((_) async => Right(tTvSeriesRecommendation));

      when(mockGetWatchlistTvSeriesStatus.execute(tvId: tTvSeriesDetail.id))
          .thenAnswer((_) async => Right(false));
      when(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail.id))
          .thenAnswer((_) async => Right(false));

      // act
      await notifier.fetchTvSeriesDetail(2);
      await notifier.removeFromWatchlist();

      // assert
      expect(notifier.addedToWatchlist, false);
    });
  });
}