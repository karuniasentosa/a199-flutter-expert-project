import '../../../../core/lib/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import '../../../../tv_series/lib/domain/entities/tv_series.dart';
import '../../../../tv_series/lib/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';

class TvSeriesWatchlistNotifier extends ChangeNotifier {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  TvSeriesWatchlistNotifier({required this.getWatchlistTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TvSeries> _watchlists = [];
  List<TvSeries> get watchlists => _watchlists;

  Future fetchWatchlistTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = getWatchlistTvSeries.execute();

    (await result).fold(_watchlistFailureCallback, _watchlistResultCallback);
  }

  void _watchlistResultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _state = RequestState.Empty;
      notifyListeners();
    } else {
      _state = RequestState.Loaded;
      _watchlists = result;
      notifyListeners();
    }
  }

  void _watchlistFailureCallback(Failure f) {
    _state = RequestState.Error;
    _errorMessage = f.message;
    notifyListeners();
  }
}