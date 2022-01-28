import '../../../../core/lib/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import '../../../../tv_series/lib/domain/entities/tv_series.dart';
import '../../../../tv_series/lib/domain/usecases/search_tv_series.dart';
import 'package:flutter/foundation.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier(this.searchTvSeries);

  RequestState _searchState = RequestState.Empty;
  RequestState get state => _searchState;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<TvSeries> _searchResultList = [];
  List<TvSeries> get searchResultList => _searchResultList;

  Future doSearchTvSeries(String query) async {
    _searchState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);

    result.fold(_failureCallback, _resultCallback);
  }

  void _failureCallback(Failure failure) {
    _searchState = RequestState.Error;
    _errorMessage = failure.message;
    notifyListeners();
  }
  
  void _resultCallback(List<TvSeries> result) {
    if (result.isEmpty) {
      _searchState = RequestState.Empty;
      notifyListeners();
    } else {
      _searchState = RequestState.Loaded;
      _searchResultList = result;
      notifyListeners();
    }
  }
}