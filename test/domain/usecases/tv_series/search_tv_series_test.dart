import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late SearchTvSeries searchTvSeries;

  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    searchTvSeries = SearchTvSeries(mockTvSeriesRepository);
  });

  test('should return a list of TvSeries when SearchTvSeries#execute is    executed', () async {
    final query = "Thrones";
    // arran
    when(mockTvSeriesRepository.searchTvSeries(query: query))
      .thenAnswer((_) async => Right(tTvSeriesSearchResult));

    // a
    final result = await searchTvSeries.execute(query);

    // assess
    expect(result, Right(tTvSeriesSearchResult));
  });

  test('should return server failure when tv series repository says that', () async {
    final query = "a";
    //
    when(mockTvSeriesRepository.searchTvSeries(query: query))
      .thenAnswer((_) async => Left(ServerFailure('')));

    //
    final result = await searchTvSeries.execute(query);

    // assert
    expect(result, Left(ServerFailure('')));
  });
}