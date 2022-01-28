import 'package:dartz/dartz.dart';
import 'package:core/failure.dart';
import 'package:tv_series/usecases.dart' show GetTvSeriesRecommendation;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


import '../../dummy_data/dummy_objects.dart';

import 'mockhelper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetTvSeriesRecommendation getTvSeriesRecommendation;

  setUp((){
    mockTvSeriesRepository = MockTvSeriesRepository();
    getTvSeriesRecommendation = GetTvSeriesRecommendation(mockTvSeriesRepository);
  });

  test('should get TV Series recommendation from tv id', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendations(id: 2))
        .thenAnswer((_) async => Right(tTvSeriesRecommendation));

    // act
    final result = await getTvSeriesRecommendation.execute(2);

    // assert
    expect(result, Right(tTvSeriesRecommendation));
  });

  test('should return error when there is a failure', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendations(id: 2))
        .thenAnswer((_) async => Left(ServerFailure('just an error')));

    // act
    final result = await getTvSeriesRecommendation.execute(2);

    // assert
    expect(result, Left(ServerFailure('just an error')));
  });
}