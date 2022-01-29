import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/usecases.dart' show GetNowPlayingMovies;

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMoviesCubit(this.getNowPlayingMovies)
      : super(NowPlayingMoviesInitial());

  Future call() async {
    emit(const NowPlayingMoviesLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
        (failure) => emit(NowPlayingMoviesError(failure.message)),
        (movies) => emit(NowPlayingMoviesResult(movies))
    );
  }
}
