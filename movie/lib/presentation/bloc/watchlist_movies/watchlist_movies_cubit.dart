import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/usecases.dart' show GetWatchlistMovies;

part 'watchlist_movies_state.dart';

class WatchlistMoviesCubit extends Cubit<WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesCubit(this.getWatchlistMovies)
      : super(WatchlistMoviesInitial());

  Future call() async {
    emit(const WatchlistMoviesLoading());

    final result = await getWatchlistMovies.execute();

    result.fold((failure) => emit(WatchlistMoviesError(failure.message)),
        (movies) => emit(WatchlistMoviesResult(movies)));
  }
}
