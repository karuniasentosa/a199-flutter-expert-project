import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/tv_series/insert_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation  getTvSeriesRecommendation;
  final InsertWatchlistTvSeries insertWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendation,
    required this.insertWatchlistTvSeries,
    required this.getWatchlistTvSeriesStatus,
    required this.removeWatchlistTvSeries,
  });

  RequestState _tvSeriesDetailState = RequestState.Empty;
  TvSeriesDetail? _tvSeriesDetail;
  String _tvSeriesDetailErrorMessage = '';

  RequestState get tvSeriesDetailState => _tvSeriesDetailState;
  TvSeriesDetail? get tvSeriesDetail => _tvSeriesDetail;
  String get tvSeriesDetailErrorMessage => _tvSeriesDetailErrorMessage;

  List<TvSeries> _tvSeriesRecommendationList = [];
  RequestState _tvSeriesRecommendationState = RequestState.Empty;

  List<TvSeries> get tvSeriesRecommendationList => _tvSeriesRecommendationList;
  RequestState get tvSeriesRecommendationState => _tvSeriesRecommendationState;

  bool _addedToWatchlist = false;
  bool get addedToWatchlist => _addedToWatchlist;

  Future fetchTvSeriesDetail(int id) async {
    _tvSeriesDetailState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesDetail.execute(id);
    result.fold(_tvSeriesDetailFailureCallback, _tvSeriesDetailResultCallback);

    if (_tvSeriesDetailState == RequestState.Error) return;
    _tvSeriesRecommendationState = RequestState.Loading;
    notifyListeners();

    await getWatchlistStatus();

    final recommendationList = await getTvSeriesRecommendation.execute(id);
    recommendationList.fold(_tvSeriesRecommendationFailureCallback, _tvSeriesRecommendationResultCallback);
  }

  Future getWatchlistStatus() async {
    if (_tvSeriesDetail == null) {
      throw Exception('tv series detail haven\'t been fetched');
    }

    final result = await getWatchlistTvSeriesStatus.execute(tvId: tvSeriesDetail!.id);

    result.fold(
            (l) => null, // do nothing, assume false
            (r) {
              _addedToWatchlist = r;
              notifyListeners();
            });
  }

  Future insertToWatchlist() async {
    if (_tvSeriesDetail == null) {
      throw Exception('tv series detail haven\'t been fetched');
    }

    await insertWatchlistTvSeries.execute(_tvSeriesDetail!);

    getWatchlistStatus();
  }

  Future removeFromWatchlist() async {
    if (_tvSeriesDetail == null) {
      throw Exception('tv series detail haven\'t been fetched');
    }

    await removeWatchlistTvSeries.execute(_tvSeriesDetail!.id);

    getWatchlistStatus();
  }


  void _tvSeriesDetailFailureCallback(Failure f) {
    _tvSeriesDetailState = RequestState.Error;
    _tvSeriesDetailErrorMessage = f.message;
    notifyListeners();
  }

  void _tvSeriesDetailResultCallback(TvSeriesDetail detail) {
    _tvSeriesDetailState = RequestState.Loaded;
    _tvSeriesDetail = detail;
    notifyListeners();
  }

  void _tvSeriesRecommendationFailureCallback(Failure f) {
    _tvSeriesRecommendationState = RequestState.Error;
    notifyListeners();
  }

  void _tvSeriesRecommendationResultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _tvSeriesRecommendationState = RequestState.Empty;
      notifyListeners();
    } else {
      _tvSeriesRecommendationState = RequestState.Loaded;
      _tvSeriesRecommendationList = result;
      notifyListeners();
    }
  }
}