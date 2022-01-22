import 'dart:convert';

import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = TvSeriesModel(
    id: 1,
    name: "Hawkeye",
    overview: 'This is an overview',
    posterPath: 'p.jpg',
  );
  final tSeriesResponse = TvSeriesResponse(showList: <TvSeriesModel>[tSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular_show_one.json'));
      // act
      final result = TvSeriesResponse.fromJsonMap(jsonMap);
      // assert
      expect(result, tSeriesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // no arrange

      // act
      final result = tSeriesResponse.toJson();

      // assert
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "name": "Hawkeye",
            "overview": "This is an overview",
            "posterPath": "p.jpg",
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}