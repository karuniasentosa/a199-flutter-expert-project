import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/usecases.dart'
    show RemoveWatchlistTvSeries, GetWatchlistTvSeriesStatus, InsertWatchlistTvSeries;

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  final InsertWatchlistTvSeries insertWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesWatchlistBloc({
    required this.getWatchlistTvSeriesStatus,
    required this.insertWatchlistTvSeries,
    required this.removeWatchlistTvSeries}) : super(TvSeriesWatchlistInitial()) {
    on<WatchlistStatusGet>(_onWatchlistStatusGet);
    on<WatchlistInsert>(_onWatchlistInsert);
    on<WatchlistRemove>(_onWatchlistRemove);
  }

  Future _onWatchlistStatusGet(WatchlistStatusGet evt, Emitter emitter) async {
    final tvId = evt.tvId;
    final result = await getWatchlistTvSeriesStatus.execute(tvId: tvId);
    result.fold(
        (l) => emitter(TvSeriesWatchlistStatusError(l.message)),
        (r) => emitter(TvSeriesWatchlistStatusResult(r))
    );
  }

  Future _onWatchlistInsert(WatchlistInsert evt, Emitter emitter) async {
    final tvDetail = evt.tvSeriesDetail;
    final result = await insertWatchlistTvSeries.execute(tvDetail);
    result.fold(
        (l) => emitter(InsertWatchlistError(l.message)),
        (r) => emitter(const InsertWatchlistSuccess())
    );
  }

  Future _onWatchlistRemove(WatchlistRemove evt, Emitter emitter) async {
    final tvId = evt.tvId;
    final result = await removeWatchlistTvSeries.execute(tvId);
    result.fold(
        (l) => emitter(RemoveWatchlistError(l.message)),
        (r) => emitter(const RemoveWatchlistSuccess())
    );
  }



}
