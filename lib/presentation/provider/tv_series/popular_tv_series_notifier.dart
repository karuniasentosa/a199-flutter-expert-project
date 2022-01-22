import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:flutter/cupertino.dart';

class PopularTvSeriesNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;
  
  PopularTvSeriesNotifier(this.getPopularTvSeries);
  
  RequestState _state = RequestState.Empty;
  RequestState get state => _state;
  
  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future fetchPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();

    result.fold(_failureCallback, _resultCallback);
  }

  void _failureCallback(Failure failure) {
    _state = RequestState.Error;
    _message = failure.message;
    notifyListeners();
  }

  void _resultCallback(List<TvSeries> series) {
    if (series.isEmpty) {
      _state = RequestState.Empty;
      notifyListeners();
    } else {
      _state = RequestState.Loaded;
      _tvSeries = series;
      notifyListeners();
    }
  }
}