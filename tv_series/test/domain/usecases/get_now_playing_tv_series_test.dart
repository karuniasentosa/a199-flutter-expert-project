import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show GetNowPlayingTvSeries;

import 'mockhelper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetNowPlayingTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('Now playing TV Series', () {
    test('should get list of movies from api repository when GetNowPlayingTvSeries#execute is called', () async {
      // arrange
      when(mockTvSeriesRepository.getNowPlayingTvSeries())
          .thenAnswer((_) async => Right(tTvSeries));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, Right(tTvSeries));
    });
  });
}