import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/usecases.dart' show SearchTvSeries;

part 'search_tv_series_state.dart';

class SearchTvSeriesCubit extends Cubit<SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesCubit(this.searchTvSeries) : super(SearchTvSeriesInitial());

  Future call(String query) async {
    emit(const SearchTvSeriesLoading());
    final result = await searchTvSeries.execute(query);
    result.fold((l) => emit(SearchTvSeriesError(l.message)),
        (r) => emit(SearchTvSeriesResult(r)));
  }
}
