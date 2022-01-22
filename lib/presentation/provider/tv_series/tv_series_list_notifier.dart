import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier
    with _PopularTvSeriesNotifier,
        _TopRatedTvSeriesNotifier,
        _NowPlayingTvSeriesNotifier {

  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  TvSeriesListNotifier({
    required this.getPopularTvSeries, 
    required this.getTopRatedTvSeries,
    required this.getNowPlayingTvSeries,
  });

  RequestState get popularTvSeriesState => _popularTvSeriesState;
  List<TvSeries> get popularTvSeriesList => _popularTvSeriesList;
  String get popularTvSeriesErrorMessage => _popularTvSeriesErrorMessage;
  Future fetchPopularTvSeries() async {
    _fetchPopularTvSeries(getPopularTvSeries);
  }

  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;
  List<TvSeries> get topRatedTvSeriesList => _topRatedTvSeriesList;
  String get topRatedTvSeriesErrorMessage => _topRatedTvSeriesErrorMessage;
  Future fetchTopRatedTvSeries() async {
    _fetchTopRatedTvSeries(getTopRatedTvSeries);
  }
  
  RequestState get nowPlayingTvSeriesState => _nowPlayingTvSeriesState;
  List<TvSeries> get nowPlayingTvSeriesList => _nowPlayingTvSeriesList;
  String get nowPlayingTvSeriesErrorMessage => _nowPlayingTvSeriesErrorMessage;
  Future fetchNowPlayingTvSeries() async {
    _fetchNowPlayingTvSeries(getNowPlayingTvSeries);
  }
}

// use mixin to prevent clutter in [TvSeriesListNotifier]

mixin _PopularTvSeriesNotifier on ChangeNotifier {
  RequestState _popularTvSeriesState = RequestState.Empty;
  List<TvSeries> _popularTvSeriesList = [];
  String _popularTvSeriesErrorMessage = '';

  Future _fetchPopularTvSeries(GetPopularTvSeries action) async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await action.execute();

    result.fold(_popularTvSeriesFailureCallback, _popularTvSeriesResultCallback);
  }

  void _popularTvSeriesFailureCallback(Failure fail) {
    _popularTvSeriesState = RequestState.Error;
    _popularTvSeriesErrorMessage = fail.message;
    notifyListeners();
  }

  void _popularTvSeriesResultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _popularTvSeriesState = RequestState.Empty;
      notifyListeners();
    } else {
      _popularTvSeriesList = result;
      _popularTvSeriesState = RequestState.Loaded;
      notifyListeners();
    }
  }
}

mixin _TopRatedTvSeriesNotifier on ChangeNotifier {
  RequestState _topRatedTvSeriesState = RequestState.Empty;
  List<TvSeries> _topRatedTvSeriesList = [];
  String _topRatedTvSeriesErrorMessage = '';

  Future _fetchTopRatedTvSeries(GetTopRatedTvSeries usecase) async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await usecase.execute();

    result.fold(_topRatedTvSeriesFailureCallback, _topRatedTvSeriesResultCallback);
  }

  void _topRatedTvSeriesFailureCallback(Failure failure) {
    _topRatedTvSeriesState = RequestState.Error;
    _topRatedTvSeriesErrorMessage = failure.message;
    notifyListeners();
  }

  void _topRatedTvSeriesResultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _topRatedTvSeriesState = RequestState.Empty;
      notifyListeners();
    } else {
      _topRatedTvSeriesState = RequestState.Loaded;
      _topRatedTvSeriesList = result;
      notifyListeners();
    }
  }
}

mixin _NowPlayingTvSeriesNotifier on ChangeNotifier {
  RequestState _nowPlayingTvSeriesState = RequestState.Empty;
  List<TvSeries> _nowPlayingTvSeriesList = [];
  String _nowPlayingTvSeriesErrorMessage = '';
  
  Future _fetchNowPlayingTvSeries(GetNowPlayingTvSeries useCase) async {
    _nowPlayingTvSeriesState = RequestState.Loading;
    notifyListeners();
    
    final result = await useCase.execute();
    
    result.fold(_nowPlayingTvSeriesFailureCallback, _nowPlayingTvSeriesResultCallback);
  }

  void _nowPlayingTvSeriesFailureCallback(Failure failure) {
    _nowPlayingTvSeriesState = RequestState.Error;
    _nowPlayingTvSeriesErrorMessage = failure.message;
    notifyListeners();
  }

  void _nowPlayingTvSeriesResultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _nowPlayingTvSeriesState = RequestState.Empty;
      notifyListeners();
    } else {
      _nowPlayingTvSeriesState = RequestState.Loaded;
      _nowPlayingTvSeriesList = result;
      notifyListeners();
    }
  }
}