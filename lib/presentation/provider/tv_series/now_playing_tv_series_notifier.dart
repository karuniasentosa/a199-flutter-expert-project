import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:flutter/cupertino.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesNotifier(this.getNowPlayingTvSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeriesList = [];
  List<TvSeries> get tvSeriesList => _tvSeriesList;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future fetchNowPlayingTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();

    result.fold(_failureCallback, _resultCallback);
  }

  void _failureCallback(Failure failure) {
    _state = RequestState.Error;
    _errorMessage = failure.message;
    notifyListeners();
  }

  void _resultCallback(List<TvSeries> series) {
    if (series.isEmpty) {
      _state = RequestState.Empty;
      notifyListeners();
    } else {
      _state = RequestState.Loaded;
      _tvSeriesList = series;
      notifyListeners();
    }
  }
}