import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/search_tv_series/search_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'usecasesmock.mocks.dart';

void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late SearchTvSeriesCubit searchTvSeriesCubit;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesCubit = SearchTvSeriesCubit(mockSearchTvSeries);
  });

  blocTest<SearchTvSeriesCubit, SearchTvSeriesState>(
    'should return list of search',
    setUp: () {
      when(mockSearchTvSeries.execute('query'))
          .thenAnswer((_) async  => Right(tTvSeriesSearchResult));
    },
    build: () => searchTvSeriesCubit,
    act: (cubit) => cubit('query'),
    expect: () => [
      const SearchTvSeriesLoading(),
      SearchTvSeriesResult(tTvSeriesSearchResult),
    ]
  );

  blocTest<SearchTvSeriesCubit, SearchTvSeriesState>(
    'should return error',
    setUp: () {
      when(mockSearchTvSeries.execute('query'))
          .thenAnswer((_) async => Left(ServerFailure('')));
    },
    build: () => searchTvSeriesCubit,
    act: (cubit) => cubit('query'),
    expect: () => [
      const SearchTvSeriesLoading(),
      const SearchTvSeriesError('')
    ]
  );
}