import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = TvSeriesModel(
      id: 2,
      name: 'Name',
      overview: 'overview',
      posterPath: '/a'
  );

  final tSeries = TvSeries(
    id: 2,
    name: 'Name',
    overview: 'overview',
    posterPath: '/a',
  );

  test('should be converted to entity',  () {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}