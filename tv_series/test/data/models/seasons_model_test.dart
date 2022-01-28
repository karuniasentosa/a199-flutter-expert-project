import 'dart:convert';

import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final seasonModel = SeasonModel(
    id: 1,
    posterPath: '/2b.jpg',
    name: 'Season 1',
    overview: 'asasasas',
    seasonNumber: 2
  );

  final seasonEntity = Season(
    id: 1,
    posterPath: '/2b.jpg',
    name: 'Season 1',
    overview: 'asasasas',
    seasonNumber: 2
  );

  final seasonJson = '''
  {
    "id": 1,
    "name": "Season 1",
    "overview": "asasasas",
    "poster_path": "/2b.jpg",
    "season_number": 2
  }
    ''';

  final seasonMap = jsonDecode(seasonJson);

  test('should be able to convert to entitiy class', () {
    final entityResult = seasonModel.toEntity();

    expect(entityResult, seasonEntity);
  });

  test('should implement deep equality class', () {
    final anotherEqualSeasonModel = SeasonModel(
        id: 1,
        posterPath: '/2b.jpg',
        name: 'Season 1',
        overview: 'asasasas',
        seasonNumber: 2
    );

    expect(anotherEqualSeasonModel, seasonModel);
  });

  test('should be able to convert from json map', () {
    final model = SeasonModel.fromJsonMap(seasonMap);

    expect(model, seasonModel);
  });
}