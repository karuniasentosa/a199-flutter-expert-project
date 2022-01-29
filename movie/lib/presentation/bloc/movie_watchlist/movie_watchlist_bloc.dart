import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchlistStatus;

  MovieWatchlistBloc(
      {required this.getWatchlistStatus,
        required this.saveWatchlist,
        required this.removeWatchlist}) : super(MovieWatchlistInitial()) {
    on<WatchlistStatusGet>(_onWatchlistStatusGet);
    on<WatchlistInsert>(_onWatchlistInsert);
    on<WatchlistRemove>(_onWatchlistRemove);
  }

  Future _onWatchlistStatusGet(WatchlistStatusGet evt, Emitter emitter) async {
    final movieId = evt.movieId;
    final result = await getWatchlistStatus.execute(movieId);
    emitter(MovieWatchlistStatus(result));
  }

  Future _onWatchlistInsert(WatchlistInsert evt, Emitter emitter) async {
    final movieDetail = evt.movieDetail;
    final result = await saveWatchlist.execute(movieDetail);
    result.fold(
            (failure) {
              final message = failure.message;
              emitter(MovieInsertWatchlistError(message));
            }, 
            (message) {
              emitter(MovieInsertWatchlistSuccess(message));
            });
  }

  Future _onWatchlistRemove(WatchlistRemove evt, Emitter emitter) async {
    final movieDetail = evt.movieDetail;
    final result = await removeWatchlist.execute(movieDetail);
    result.fold(
            (failure) {
              final message = failure.message;
              emitter(MovieRemoveWatchlistError(message));
            }, 
            (message) {
              emitter(MovieRemoveWatchlistSuccess(message));
            });
  }
}
