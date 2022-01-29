import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:movie/domain/entities/movie.dart';

import 'package:movie/usecases.dart' show GetTopRatedMovies;

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesCubit(this.getTopRatedMovies)
      : super(TopRatedMoviesInitial());

  Future call() async {
    emit(const TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
        (failure) => emit(TopRatedMoviesError(failure.message)),
        (movies) => emit(TopRatedMoviesResult(movies))
    );
  }
}
