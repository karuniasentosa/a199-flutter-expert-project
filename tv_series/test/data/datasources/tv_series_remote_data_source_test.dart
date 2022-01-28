import 'dart:convert';
import 'dart:io';

import 'package:core/exception.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

import '../../json_reader.dart';
import 'tv_series_remote_data_source_test.mocks.dart';

@GenerateMocks(
    [],
    customMocks: [
      MockSpec<http.Client>(as: #MockHttpClient)
    ]
)
void main() {
  const apiKey = '2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'api.themoviedb.org';
  const queryParams = {'api_key': apiKey};

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get popular tv series', () {
    final tTvSeriesList = TvSeriesResponse.fromJsonMap(
            jsonDecode(readJson('dummy_data/popular_show.json')))
        .showList;

    test('should return list of tv series when response is success(200)',
        () async {
      // arrange
      final uri = Uri.https(baseUrl, '/3/tv/popular', queryParams);

      // > The Response class uses Latin-1 encoding for the body unless something else is specified.
      // https://stackoverflow.com/questions/52990816/dart-json-encodedata-can-not-accept-other-language/52993623#52993623
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response(
              readJson('dummy_data/popular_show.json'), 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, tTvSeriesList);
    });
  });

  group('get now playing tv series', () {
    final tTvSeriesList = TvSeriesResponse.fromJsonMap(
            jsonDecode(readJson('dummy_data/popular_show.json')))
        .showList;

    test('should return list of tv series when response is success(200)',
        () async {
      // arrange
      final uri = Uri.https(baseUrl, '/3/tv/on_the_air', queryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response(
              readJson('dummy_data/popular_show.json'), 200, headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          }));

      // act
      final result = await dataSource.getNowPlayingTvSeries();

      // assert
      expect(result, tTvSeriesList);
    });
  });

  group('get tv series detail', () {
    final tvId = 2;
    final json = readJson('dummy_data/tv_series_detail.json');
    final tTvSeriesDetail = TvSeriesDetailModel.fromJsonMap(
      jsonDecode(json));

    test('should return tv detail when response is success(200)', () async {
      // arrange
      final uri = Uri.https(baseUrl, '/3/tv/$tvId', queryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response(json, 200));

      // act
      final result = await dataSource.getTvSeriesDetail(id: tvId);

      // assert
      expect(result, tTvSeriesDetail);
    });

    test('should throw exception when other response is received', () {
      // arrange
      final uri = Uri.https(baseUrl, '/3/tv/$tvId', queryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response('', 404));

      // act
      final result = dataSource.getTvSeriesDetail(id: tvId);

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('Tv series recommendation', (){
    final tvId = 2;
    final json = readJson('dummy_data/tv_series_recommendations.json');
    final tvSeriesResponse = TvSeriesResponse.fromJsonMap(jsonDecode(json));

    test('should return tv recommendations from selected id', () async {
      // ararnge
      final uri = Uri.https(baseUrl, '/3/tv/$tvId/recommendations', queryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response(json, 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));

      // act
      final result = dataSource.getTvSeriesRecommendations(id: tvId);

      // assert
      expect(await result, tvSeriesResponse.showList);
    });

    test('should throw a exception response is not 200', () {
      // arrange
      // ararnge
      final uri = Uri.https(baseUrl, '/3/tv/$tvId/recommendations', queryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response('', 201));

      // act
      final result = dataSource.getTvSeriesRecommendations(id: tvId);

      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });

  group('tv search query', () {
    final query = 'thrones';
    final json = readJson('dummy_data/search_tv_result_sample.json');
    final tvSeriesResponse = TvSeriesResponse.fromJsonMap(jsonDecode(json));

    final Map<String, String> searchQueryParams = {};
    searchQueryParams.addAll(queryParams);
    searchQueryParams.addAll({'query': query});

    test('should return search response when query is sent', () async {
      // arrange
      final uri = Uri.https(baseUrl, '/3/search/tv/', searchQueryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response(json, 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      }));

      // act
      final result = dataSource.searchTvSeries(query: query);

      // assert
      expect(await result, tvSeriesResponse.showList);
    });

    test("should return error when          response is not 200", () async {
      // arrange
      final uri = Uri.https(baseUrl, '/3/search/tv/', searchQueryParams);
      when(mockHttpClient.get(uri)).thenAnswer((_) async => http.Response('', 404));

      // act
      final result = dataSource.searchTvSeries(query: query);

      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
}
