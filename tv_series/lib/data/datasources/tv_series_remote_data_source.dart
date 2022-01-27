import 'dart:convert';

import '../../../../core/lib/common/exception.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id});
  Future<List<TvSeriesModel>> getTvSeriesRecommendations({required int id});
  Future<List<TvSeriesModel>> searchTvSeries({required String query});
}

class TvSeriesRemoteDataSourceImpl extends TvSeriesRemoteDataSource {
  static const _apiKey = '2174d146bb9c0eab47529b2e77d6b526';
  static const _baseUrl = 'api.themoviedb.org';
  static const _queryParams = { 'api_key': _apiKey };

  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final uri = Uri.https(_baseUrl, '3/tv/popular', _queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJsonMap(jsonDecode(response.body)).showList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final uri = Uri.https(_baseUrl, '3/tv/top_rated', _queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJsonMap(jsonDecode(response.body)).showList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final uri = Uri.https(_baseUrl, '3/tv/on_the_air', _queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJsonMap(jsonDecode(response.body)).showList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailModel> getTvSeriesDetail({required int id}) async {
    final uri = Uri.https(_baseUrl, '/3/tv/$id', _queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvSeriesDetailModel.fromJsonMap(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations({required int id}) async {
    final uri = Uri.https(_baseUrl, '/3/tv/$id/recommendations', _queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJsonMap(jsonDecode(response.body)).showList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries({required String query}) async {
    final Map<String, String> searchQueryParams = Map()
      ..addAll(_queryParams)
      ..addAll({'query': query});

    final uri = Uri.https(_baseUrl, '/3/search/tv/', searchQueryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJsonMap(jsonDecode(response.body)).showList;
    } else {
      throw ServerException();
    }
  }
}